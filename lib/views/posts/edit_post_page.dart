import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/models/post_model.dart';
import 'package:flutter_simple_blog/viewmodels/create_post_viewmodel.dart';
import 'package:flutter_simple_blog/widgets/post_form.dart';
import 'package:provider/provider.dart';

class EditPostPage extends StatelessWidget {
  final PostModel post;

  const EditPostPage({super.key, required this.post});

  Widget displayForm(CreatePostViewmodel vm) {
    if (vm.authService.isLoggedIn) {
      return PostForm(
        initialTitle: post.title,
        initialBody: post.body,
        submitText: 'Post',
        titleValidator: vm.validateTitle,
        onSubmit: (title, body) {
          return vm.updatePost(title, body);
        },
      );
    }
    return LoginReminder();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreatePostViewmodel(),
      child: Consumer<CreatePostViewmodel>(
        builder: (context, value, child) => displayForm(value),
      ),
    );
  }
}
