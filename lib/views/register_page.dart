import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/users_controller.dart';
import 'package:flutter_simple_blog/widgets/email_field.dart';
import 'package:flutter_simple_blog/widgets/password_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void backToLoginPage(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => backToLoginPage(context),
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text('Create an account'),
        centerTitle: true,
      ),
      body: RegisterForm(),
    );
  }
}

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
    return Consumer<UsersController>(
      builder: (context, value, child) => Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      .then((success) => print('Success $success')),
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
