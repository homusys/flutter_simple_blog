import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/models/post_model.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';

class PostsViewmodel extends ChangeNotifier {
  final AuthService authService = AuthService();
  final postsTable = 'posts';

  PostModel? _currentPost;

  PostModel? get currentPost => _currentPost;

  Future<List<Map<String, dynamic>>> getPost(int postId) {
    return authService.supaClient
        .from(postsTable)
        .select('''
        *, 
        post_images(id, image_url),
        profiles(id, email, avatar_url)''')
        .eq('id', postId);
  }

  Future<PostModel> getThisPost(int postId) async {
    var post = await authService.supaClient
        .from(postsTable)
        .select('''
        *, 
        post_images(id, image_url),
        profiles(id, email, avatar_url)''')
        .eq('id', postId)
        .single();

    var postImages = post['post_images'];

    return PostModel(
      postId: post['id'],
      createdAt: post['created_at'],
      createdBy: post['profiles']['email'],
      title: post['title'],
      body: post['body'],
      imageUrls: [for (final postImg in postImages) postImg['image_url']],
    );
  }

  void updatePost(int postId, String title, String body) async {
    if (authService.isLoggedIn) {
      var test = await authService.supaClient
          .from(postsTable)
          .update({'title': title, 'body': body})
          .eq('id', postId)
          .select();

      print(test.toString());
      notifyListeners();
    } else {
      print('NOT YET LOGGED IN');
    }
  }

  void deletePost() async {}
}
