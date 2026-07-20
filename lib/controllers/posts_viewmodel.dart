import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';

class PostsViewmodel extends ChangeNotifier {
  final AuthService authService = AuthService();
  final postsTable = 'posts';

  void createPost(String title, String body) async {
    if (authService.isLoggedIn) {
      try {
        var test = await authService.supaClient.from(postsTable).insert({
          'title': title,
          'body': body,
          'user_uuid': authService.currentUser!.id,
        }).select();
        print(test.toString());
        notifyListeners();
      } catch (error) {
        print(error);
      }
    } else {
      print('Not logged in');
    }
  }

  Future<List<Map<String, dynamic>>> getPost(int postId) {
    return authService.supaClient.from(postsTable).select().eq('id', postId);
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

  Future<dynamic> deletePost() async {}
}
