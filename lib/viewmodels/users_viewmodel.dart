import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersViewmodel extends ChangeNotifier {
  final AuthService authService = AuthService();

  String getCurrentUserEmail() {
    if (authService.isLoggedIn) {
      return authService.currentUser!.email.toString();
    }
    return 'Profile';
  }

  /// Checks whether an input string is in a valid email address format.
  static String? validateEmail(String? email) {
    return email != null && !EmailValidator.validate(email)
        ? 'Not a valid email address.'
        : null;
  }

  /// Checks whether an input string is in a valid password format.
  static String? validatePassword(String? pass) {
    const String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final RegExp regExp = RegExp(pattern);

    if (pass == null || pass.isEmpty) {
      return 'Please enter a password.';
    } else if (!regExp.hasMatch(pass)) {
      return """A password must be at least 8 characters in length and must contain: 
      - An upper case character,
      - A lower case character, 
      - A digit, 
      - A special character""";
    }
    return null;
  }

  Future<bool> registerUser(
    GlobalKey<FormState> formKey,
    String email,
    String pass,
  ) async {
    final AuthResponse res;
    Session? session;
    User? user;

    try {
      if (formKey.currentState!.validate()) {
        res = await authService.supaClient.auth.signUp(
          email: email,
          password: pass,
        );

        user = res.user;
        session = res.session;
      }
    } on AuthException catch (error) {
      ///TODO(homus): handle exceptions.
      print('Auth error: $error');
    } catch (error) {
      print('Unhandled exception: $error');
    } finally {
      notifyListeners();
    }
    return (user != null && session != null);
  }

  Future<bool> loginUser(
    GlobalKey<FormState> formKey,
    String email,
    String pass,
  ) async {
    final AuthResponse res;
    Session? session;

    try {
      if (formKey.currentState!.validate()) {
        res = await authService.supaClient.auth.signInWithPassword(
          email: email,
          password: pass,
        );
        session = res.session;
      }
    } on AuthException catch (error) {
      print('Auth error: $error');
    } catch (error) {
      print('Unhandled exception: $error');
    }
    notifyListeners();
    return (authService.currentUser != null && session != null);
  }

  Future<void> logoutUser() async {
    final SupabaseClient supabase;
    void res;

    try {
      supabase = Supabase.instance.client;
      res = await supabase.auth.signOut();
    } catch (error) {
      print('Logout error: $error');
    } finally {
      notifyListeners();
    }

    return res;
  }
}
