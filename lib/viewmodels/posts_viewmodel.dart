import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/models/comment_images_model.dart';
import 'package:flutter_simple_blog/models/comment_model.dart';
import 'package:flutter_simple_blog/models/post_images_model.dart';
import 'package:flutter_simple_blog/models/post_model.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';

class PostsViewmodel extends ChangeNotifier {
  final AuthService authService = AuthService();
  final postsTable = 'posts';

  PostModel? _currentPost;
  final List<CommentModel> _comments = [];
  bool _commentsIsLoading = false;

  List<CommentModel> get comments => _comments;
  PostModel? get currentPost => _currentPost;
  bool get commentsIsLoading => _commentsIsLoading;

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
        post_images(*),
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
      images: [
        for (final postImg in postImages)
          PostImagesModel(
            postImageId: postImg['id'],
            postId: post['id'],
            createdAt: postImg['created_at'],
            publicUrl: postImg['public_url'],
            bucketPath: postImg['bucket_path'],
          ),
      ],
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

  Future<void> getAllCommentsFromPost(int postId) async {
    _comments.clear();

    _commentsIsLoading = true;
    notifyListeners();
    try {
      final comments = await authService.supaClient
          .from('comments')
          .select('''*,
          comment_images (*),
          profiles (*)''')
          .eq('post_id', postId)
          .order('created_at', ascending: false);

      for (final comment in comments) {
        final commentImages = comment['comment_images'];

        _comments.add(
          CommentModel(
            id: comment['id'],
            createdAt: comment['created_at'],
            createdBy: comment['profiles']['email'],
            body: comment['body'],
            postId: postId,
            images: [
              for (final img in commentImages)
                CommentImagesModel(
                  id: img['id'],
                  createdAt: img['created_at'],
                  commentId: comment['id'],
                  bucketPath: img['bucket_path'],
                  publicUrl: img['public_url'],
                ),
            ],
          ),
        );
      }
    } catch (error) {
      ///
    } finally {
      _commentsIsLoading = false;
      notifyListeners();
    }
  }

  String? validateCommentBody(String? body) {
    return (body == null || body.isEmpty)
        ? 'Please add a comment first.'
        : null;
  }

  Future<void> createComment(
    GlobalKey<FormState> formKey,
    int postId,
    String body,
  ) async {
    if (authService.isLoggedIn && formKey.currentState!.validate()) {
      try {
        var res = await authService.supaClient.from('comments').insert({
          'post_id': postId,
          'profile_id': authService.currentUser!.id,
          'body': body,
        }).select();
        print(res.toString());
      } catch (error) {
        print(error);
      } finally {
        getAllCommentsFromPost(postId);
        notifyListeners();
      }
    }
  }
}
