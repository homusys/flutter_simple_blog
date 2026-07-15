import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        
      ],),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 5.0,
          children: [
            Text('Login'),
            LoginField(labelText: 'Username', onLogin: (placeholder) => {}),
            LoginField(labelText: 'Password', onLogin: (placeholder) => {}),
          ],
        ),
      ),
    );
  }
}

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    this.labelText = 'Placeholder',
    required this.onLogin,
    this.maxLength = 255,
  });

  final void Function(String) onLogin;
  final String labelText;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: labelText,
      ),
    );
  }
}
