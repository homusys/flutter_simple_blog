import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/views/register_page.dart';
import 'package:flutter_simple_blog/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginForm();
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submit() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // TODO(homusys): Integrate database behaviour on LoginController.
    print('Email: $email');
    print('Password: $password');

    /** TODO(homusys): 
     * Return a boolean value based on the result. Will be used for clearing the 
     * form inputs. */

    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = CustomTextField(
      controller: _emailController,
      labelText: 'Email',
    );
    final passwordField = CustomTextField(
      controller: _passwordController,
      labelText: 'Password',
      obscureText: true,
    );

    return Padding(
      padding: EdgeInsetsGeometry.all(8.0),
      child: Column(
        children: [
          Text('Login'),
          emailField,
          passwordField,
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text("Don't have an account?"),
          ),
        ],
      ),
    );
  }
}

// class LoginField extends StatelessWidget {
//   LoginField({
//     super.key,
//     this.labelText = 'Placeholder',
//     this.onLogin,
//     required this.controller,
//     this.maxLength = 255,
//   });

//   final void Function(String)? onLogin;
//   final String labelText;
//   final int maxLength;

//   final TextEditingController controller;
//   final FocusNode _focusNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       autofocus: true,
//       maxLength: maxLength,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//         ),
//         labelText: labelText,
//       ),
//       controller: controller,
//       focusNode: _focusNode,
//       onSubmitted: null,
//     );
//   }
// }
