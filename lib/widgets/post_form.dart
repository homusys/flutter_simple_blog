import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/widgets/image_upload_field.dart';
import 'package:flutter_simple_blog/widgets/post_text_field.dart';

class PostForm extends StatefulWidget {
  final String initialTitle;
  final String initialBody;
  final String submitText;

  final String? Function(String?)? titleValidator;

  final Future<void> Function(String title, String body) onSubmit;

  const PostForm({
    super.key,
    required this.onSubmit,
    this.initialTitle = '',
    this.initialBody = '',
    this.submitText = 'Post',
    this.titleValidator,
  });

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.initialTitle);
    _bodyController = TextEditingController(text: widget.initialBody);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PostTextField(
                controller: _titleController,
                labelText: "Post title",
                validator: widget.titleValidator,
              ),

              PostTextField(
                controller: _bodyController,
                labelText: "Post Body",
                maxLength: 0xFFFF,
                maxLines: 8,
                validator: null,
              ),
              ImageUploadField(),
              TextButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  widget
                      .onSubmit(
                        _titleController.text.trim(),
                        _bodyController.text.trim(),
                      )
                      .then((value) {
                        if (!context.mounted) {
                          return;
                        }
                        _titleController.clear();
                        _bodyController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${widget.submitText} successful'),
                          ),
                        );
                      });
                },
                child: Text(widget.submitText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// This widget is used instead of the form when the user is not logged in
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
