import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/users_controller.dart';

/// The EmailField handles client-side text input email validation.
class EmailField extends StatefulWidget {
  const EmailField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: [AutofillHints.email],
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        hintText: 'Email',
        prefixIcon: Icon(Icons.email_rounded),
      ),
      keyboardType: TextInputType.emailAddress,

      /// Using the email validator package.
      validator: (email) => UsersController.validateEmail(email),
    );
  }
}
