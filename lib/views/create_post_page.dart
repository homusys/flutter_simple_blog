import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/posts_viewmodel.dart';
import 'package:flutter_simple_blog/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CreatePostForm();
  }
}

class CreatePostForm extends StatelessWidget {
  CreatePostForm({super.key});

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          CustomTextField(
            controller: _titleController,
            labelText: "Post title",
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(height: 20, child: Placeholder()),
          ),
          CustomTextField(
            controller: _bodyController,
            labelText: 'Post Body',
            maxLength: 0xFFFF,
            maxLines: null,
          ),
          Consumer<PostsViewmodel>(
            builder: (context, value, child) => TextButton(
              onPressed: () {
                value.createPost(_titleController.text, _bodyController.text);
              },
              child: Text('Post'),
            ),
          ),
        ],
      ),
    );
  }
}
