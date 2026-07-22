import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/viewmodels/users_viewmodel.dart';
import 'package:flutter_simple_blog/widgets/email_field.dart';
import 'package:flutter_simple_blog/widgets/password_field.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersViewmodel>(
      builder: (context, value, child) => Form(
        key: _formKey,
        child: Column(
          children: [
            EmailField(controller: _emailController),
            PasswordField(controller: _passwordController),
            TextButton(
              onPressed: () => {
                value
                    .registerUser(
                      _formKey,
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    )
                    .then((success) {
                      if (success) {
                        if (context.mounted) {
                          _emailController.clear();
                          _passwordController.clear();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Registered successfully!')),
                          );
                        }
                      }
                    }),
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
