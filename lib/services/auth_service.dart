import 'package:supabase_flutter/supabase_flutter.dart';

/// This class is used as an interface between the Supabase Auth API, more
/// specifically, auth's Users table. The purpose of this class is to avoid
/// having to repeatedly allocate variables for some auth properties.
class AuthService {
  SupabaseClient get supaClient => Supabase.instance.client;

  User? get currentUser => supaClient.auth.currentUser;

  bool get isLoggedIn => currentUser != null;
}
