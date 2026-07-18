import 'package:email_validator/email_validator.dart';

class UsersController {
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
}
