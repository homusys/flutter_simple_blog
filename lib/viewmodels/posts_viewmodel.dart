import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';

class PostsViewmodel extends ChangeNotifier {
  final AuthService authService = AuthService();
  final postsTable = 'posts';

  Future<List<Map<String, dynamic>>> getPost(int postId) {
    return authService.supaClient.from(postsTable).select().eq('id', postId);
  }

  Future<List<Map<String, dynamic>>> getAllPosts() {
    return authService.supaClient.from(postsTable).select('''
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
    ''');
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
