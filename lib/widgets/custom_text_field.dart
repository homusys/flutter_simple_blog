import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
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
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      maxLength: maxLength,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: labelText,
      ),
      controller: controller,
      focusNode: _focusNode,
      maxLines: maxLines,
      onSubmitted: null,
      obscureText: obscureText,
    );
  }
}
