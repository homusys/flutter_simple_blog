import 'package:flutter/material.dart';

class PostTextField extends StatefulWidget {
  const PostTextField({
    super.key,
    required this.controller,
    this.validator,
    this.onLogin,
    this.maxLines = 1,
    this.labelText = 'Placeholder',
    this.maxLength = 255,
    this.obscureText = false,
  });

  final void Function(String)? onLogin;
  final String labelText;
  final int maxLength;
  final bool obscureText;
  final int? maxLines;

  final TextEditingController controller;

  final String? Function(String?)? validator;

  @override
  State<PostTextField> createState() => _PostTextFieldState();
}

class _PostTextFieldState extends State<PostTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: widget.labelText,
        alignLabelWithHint: true,
      ),
      controller: widget.controller,
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      validator: widget.validator,
    );
  }
}
