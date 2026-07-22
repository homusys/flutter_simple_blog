import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/models/post_model.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';

class HomeViewmodel extends ChangeNotifier {
  final AuthService authService = AuthService();

  bool _isLoading = false;
  List<PostModel> _posts = [];

  bool get isLoading => _isLoading;
  List<PostModel> get posts => _posts;

  Future<void> getAllPosts() async {
    _posts.clear();

    _isLoading = true;
    notifyListeners();

    /// TODO(homusys): make this a database service
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
      _posts.add(
        PostModel(
          postId: post['id'],
          createdAt: post['created_at'],
          createdBy: post['profiles']['email'],
          title: post['title'],
        ),
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}
