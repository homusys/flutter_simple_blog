import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/views/auth/login_form.dart';
import 'package:flutter_simple_blog/views/auth/register_form.dart';

enum AuthFormType { login, signup }

class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required this.authFormType});
  final AuthFormType authFormType;

  Widget displayForm() {
    switch (authFormType) {
      case AuthFormType.login:
        return LoginForm();
      case AuthFormType.signup:
        return RegisterForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: displayForm(),
    );
  }
}
