import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/users_viewmodel.dart';

/// The PasswordField handles password inputs.
class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: [AutofillHints.password],
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        hintText: 'Password',
        prefixIcon: Icon(Icons.lock_rounded),
      ),
      obscureText: true,
      validator: (pass) => UsersViewmodel.validatePassword(pass),
    );
  }
}
