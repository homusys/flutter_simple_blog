import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/widgets/custom_text_field.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomTextField(controller: _emailController, labelText: 'Email'),
          CustomTextField(
            controller: _passwordController,
            labelText: 'Password',
            obscureText: true,
          ),
          TextButton(onPressed: () {}, child: Text('Register')),
        ],
      ),
    );
  }
}
