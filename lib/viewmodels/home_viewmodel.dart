import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/models/post_model.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';
import 'package:flutter_simple_blog/services/storage_service.dart';

class HomeViewmodel extends ChangeNotifier {
  final AuthService authService = AuthService();
  final StorageService storageService = StorageService();

  bool _isLoading = false;
  bool _runOnce = false;
  final List<PostModel> _posts = [];

  bool get isLoading => _isLoading;
  List<PostModel> get posts => _posts;

  Future<void> getAllPosts({bool forceRefresh = false}) async {
    if (_isLoading) {
      return;
    }

    /// This method should only run once and reuse all existing posts to
    /// avoid spam. The user must refresh the page or use the refresh button
    /// to get the latest data.
    if (_runOnce && !forceRefresh) {
      return;
    }

    _runOnce = true;

    _posts.clear();
    _isLoading = true;
    notifyListeners();

    /// TODO(homusys): make this a database service
    try {
      var res = await authService.supaClient
          .from('posts')
          .select('''
      *,
      post_images (
        id,
        image_url
      ),
      profiles (
        id, 
        email,
        avatar_url
      )
    ''')
          .order('created_at', ascending: false);

      for (final post in res) {
        var postImages = post['post_images'];

        _posts.add(
          PostModel(
            postId: post['id'],
            createdAt: post['created_at'],
            createdBy: post['profiles']['email'],
            title: post['title'],
            imageUrls: [for (final postImg in postImages) postImg['image_url']],
          ),
        );
      }
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePost(int postId) async {
    print(postId);
    if (!authService.isLoggedIn) {
      return;
    }

    try {
      /// Get all the owner-uploaded image urls related to the post.
      final images = await authService.supaClient
          .from('post_images')
          .select('image_url')
          .eq('post_id', postId);

      /// Delete all images related to post id.
      if (images.isNotEmpty) {
        await storageService.supaStorage
            .from('post_images')
            /// https://stackoverflow.com/questions/55789048/what-does-the-as-keyword-do-in-dart-language
            .remove(images.map((e) => e['image_url'] as String).toList());
      }

      /// This should cascade deletion to all data referencing this id.
      await authService.supaClient.from('posts').delete().eq('id', postId);
    } catch (error) {
      print('$error');
    } finally {
      notifyListeners();
    }
  }
}
