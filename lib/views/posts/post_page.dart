import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/models/comment_model.dart';
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
        builder: (context, vm, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                blendMode: BlendMode.difference,
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: FutureBuilder(
            future: vm.getThisPost(postId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final post = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// POST IMAGE
                    if (post.images != null && post.images!.isNotEmpty)
                      Image(image: NetworkImage(post.images![0].publicUrl)),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0,
                        top: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: CircleAvatar(
                                  foregroundImage: AssetImage(
                                    'assets/images/portrait.png',
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                post.createdBy,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),

                          /// POST TITLE
                          Text(
                            post.title,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight(600),
                                ),
                          ),

                          /// POST BODY
                          Text(
                            post.body,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.white60),
                          ),
                          Divider(height: 80, thickness: 1),
                          CommentForm(postId: postId),

                          Divider(height: 80, thickness: 1),
                          CommentSection(postId: postId, vm: vm),
                        ],
                      ),
                    ),
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

  Widget showForm(BuildContext context, PostsViewmodel vm) {
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
                onPressed: () => vm
                    .createComment(
                      _formKey,
                      widget.postId,
                      _bodyController.text.trim(),
                    )
                    .then((value) {
                      _bodyController.clear();

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Comment posted!')),
                      );
                    }),
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
    return Consumer<PostsViewmodel>(
      builder: (context, value, child) =>
          Form(key: _formKey, child: showForm(context, value)),
    );
  }
}

class CommentSection extends StatefulWidget {
  final int postId;
  final PostsViewmodel vm;
  const CommentSection({super.key, required this.postId, required this.vm});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.vm.getAllCommentsFromPost(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.vm.commentsIsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.vm.comments.isEmpty) {
      return const Text('No comments yet. Be the first one.');
    }

    return Column(
      children: [
        for (final comment in widget.vm.comments)
          CommentItem(commentModel: comment),
      ],
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentModel commentModel;

  const CommentItem({super.key, required this.commentModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commentModel.createdBy,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(commentModel.body),
            ],
          ),
        ],
      ),
    );
  }
}
