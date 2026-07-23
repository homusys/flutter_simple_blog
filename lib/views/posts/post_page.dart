import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/models/comment_model.dart';
import 'package:flutter_simple_blog/viewmodels/comments_viewmodel.dart';
import 'package:flutter_simple_blog/viewmodels/posts_viewmodel.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key, required this.postId});
  final int postId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostsViewmodel(),
      child: Consumer<PostsViewmodel>(
        builder: (context, value, child) => Scaffold(
          /// TODO(homusys):
          /// compare future builder and viewmodel
          body: FutureBuilder(
            future: value.getThisPost(postId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final post = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    /// POST IMAGE
                    if (post.imageUrls != null && post.imageUrls!.isNotEmpty)
                      Image(image: NetworkImage(post.imageUrls![0])),

                    /// POST TITLE
                    Text(post.title),

                    /// POST BODY
                    Text(post.body),
                    Divider(height: 120, thickness: 80),
                    CommentForm(postId: postId),
                    Divider(height: 80, thickness: 1),
                    CommentSection(postId: postId),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CommentForm extends StatefulWidget {
  final int postId;

  const CommentForm({super.key, required this.postId});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bodyController = TextEditingController();

  Widget showForm(CommentsViewmodel vm) {
    if (vm.authService.isLoggedIn) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _bodyController,
                  decoration: InputDecoration(hintText: 'Write a comment..'),
                  maxLines: 3,
                  validator: (body) => vm.validateCommentBody(body),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              TextButton(
                onPressed: () => vm.createComment(
                  _formKey,
                  widget.postId,
                  _bodyController.text.trim(),
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ],
      );
    }
    return Text('You must be logged in to comment.');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentsViewmodel>(
      builder: (context, value, child) =>
          Form(key: _formKey, child: showForm(value)),
    );
  }
}

class CommentSection extends StatelessWidget {
  final int postId;
  const CommentSection({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    /// Turn into future builder into a listview.builder.

    return Consumer<CommentsViewmodel>(
      builder: (context, value, child) => FutureBuilder(
        future: value.getAllCommentsFromPost(postId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final comments = snapshot.data!;
          if (comments.isEmpty) {
            return Text('No comments yet. Be the first one.');
          }

          return Column(
            children: [
              for (int i = 0; i < comments.length; ++i)
                CommentItem(
                  commentModel: CommentModel(
                    id: comments[i]['id'],
                    createdAt: comments[i]['created_at'],
                    createdBy: comments[i]['profiles']['email'],
                    body: comments[i]['body'],
                    postId: comments[i]['post_id'],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentModel commentModel;

  const CommentItem({super.key, required this.commentModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(commentModel.createdBy), Text(commentModel.body)],
        ),
      ],
    );
  }
}
