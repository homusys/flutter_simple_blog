import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/widgets/email_field.dart';
import 'package:flutter_simple_blog/widgets/password_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  void registerUser() async {
    final Session? session;
    final User? user;

    try {
      if (!_formKey.currentState!.validate()) {
        return; // all validations must pass.
      }
      final supabase = Supabase.instance.client;
      final AuthResponse res = await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
      session = res.session;
      user = res.user;
      print('Session $session');
      print('User $user');
    } on AuthException catch (error) {
      print('Auth error: $error');
    } catch (error) {
      print('Unhandled exception: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            EmailField(controller: _emailController),
            PasswordField(controller: _passwordController),
            TextButton(onPressed: registerUser, child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
