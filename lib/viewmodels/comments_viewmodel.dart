import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';

class CommentsViewmodel extends ChangeNotifier {
  AuthService authService = AuthService();
  final String commentsTable = 'comments';

  Future<List<Map<String, dynamic>>> getAllCommentsFromPost(int postId) {
    return authService.supaClient
        .from(commentsTable)
        .select('''
          *,
          comment_images (
            id
          )
        ''')
        .eq('post_id', postId);
  }

  String? validateCommentBody(String? body) {
    return (body == null || body.isEmpty)
        ? 'Please add a comment first.'
        : null;
  }

  void createComment(
    GlobalKey<FormState> formKey,
    int postId,
    String body,
  ) async {
    if (authService.isLoggedIn && formKey.currentState!.validate()) {
      try {
        var res = await authService.supaClient.from(commentsTable).insert({
          'post_id': postId,
          'profile_id': authService.currentUser!.id,
          'body': body,
        }).select();
        print(res.toString());
      } catch (error) {
        print(error);
      }
    }
  }
}
