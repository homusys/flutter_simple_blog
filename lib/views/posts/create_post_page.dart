import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/viewmodels/create_post_viewmodel.dart';
import 'package:flutter_simple_blog/widgets/post_form.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  Widget displayForm(CreatePostViewmodel vm) {
    if (vm.authService.isLoggedIn) {
      return PostForm(
        onSubmit: (title, body) {
          return vm.createPost(title, body);
        },
        submitText: 'Post',
        titleValidator: vm.validateTitle,
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
