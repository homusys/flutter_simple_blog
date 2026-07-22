import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/viewmodels/create_post_viewmodel.dart';
import 'package:flutter_simple_blog/widgets/post_text_field.dart';
import 'package:flutter_simple_blog/widgets/image_upload_field.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  Widget displayForm(CreatePostViewmodel vm) {
    if (vm.authService.isLoggedIn) {
      return CreatePostForm(vm: vm);
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

class LoginReminder extends StatelessWidget {
  const LoginReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You must be logged in before posting."),
          Text("(Click the profile button below.)"),
        ],
      ),
    );
  }
}

class CreatePostForm extends StatelessWidget {
  final CreatePostViewmodel vm;

  CreatePostForm({super.key, required this.vm});

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            PostTextField(
              controller: _titleController,
              labelText: "Post title",
            ),

            PostTextField(
              controller: _bodyController,
              labelText: "Post Body",
              maxLength: 0xFFFF,
              maxLines: null,
            ),
            ImageUploadField(),
            TextButton(
              onPressed: () {
                vm.createPost(_titleController.text, _bodyController.text).then(
                  (value) {
                    if (context.mounted) {
                      _titleController.clear();
                      _bodyController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text("Post created")),
                      );
                    }
                  },
                );
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
