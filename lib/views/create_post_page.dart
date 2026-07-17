import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/widgets/custom_text_field.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CreatePostForm();
  }
}

class CreatePostForm extends StatefulWidget {
  const CreatePostForm({super.key});

  @override
  State<CreatePostForm> createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
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
          /**TODO(homusys):
           * Figure out how to implement uploading of files. */
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
          TextButton(onPressed: () {}, child: Text('Post')),
        ],
      ),
    );
  }
}
