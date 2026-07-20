import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/users_viewmodel.dart';
import 'package:flutter_simple_blog/widgets/email_field.dart';
import 'package:flutter_simple_blog/widgets/password_field.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = EmailField(controller: _emailController);
    final passwordField = PasswordField(controller: _passwordController);

    return Consumer<UsersViewmodel>(
      builder: (context, value, child) => Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: Column(
            children: [
              Text('Login'),
              emailField,
              passwordField,
              TextButton(
                onPressed: () => value
                    .loginUser(
                      _formKey,
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    )
                    .then((success) {
                      if (success) {
                        _emailController.clear();
                        _passwordController.clear();
                        print('LOGIN SUCCESS');
                      }
                    }),
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
