import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/themes/styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        
      ],),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submit() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // TODO(homusys): Integrate database behaviour on LoginController.
    print('Username: $username');
    print('Password: $password');

    /** TODO(homusys): 
     * Return a boolean value based on the result. Will be used for clearing the 
     * form inputs. */
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = LoginField(controller: _usernameController);
    final passwordField = LoginField(controller: _passwordController);

    return Padding(
      padding: EdgeInsetsGeometry.all(8.0),
      child: Column(
        children: [
          Text('Login'),
          usernameField,
          passwordField,
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class LoginField extends StatelessWidget {
  LoginField({
    super.key,
    this.labelText = 'Placeholder',
    this.onLogin,
    required this.controller,
    this.maxLength = 255,
  });

  final void Function(String)? onLogin;
  final String labelText;
  final int maxLength;

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
      onSubmitted: null,
    );
  }
}
