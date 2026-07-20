import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostsViewmodel extends ChangeNotifier {
  final postsTable = 'posts';

  SupabaseClient get supaClient => Supabase.instance.client;
  User? get user => supaClient.auth.currentUser;
  bool get isLoggedin => user != null;

  void createPost(String title, String body) async {
    if (isLoggedin) {
      try {
        var test = await supaClient.from(postsTable).insert({
          'title': title,
          'body': body,
          'user_uuid': user!.id,
        }).select();
        print(test.toString());
        notifyListeners();
      } catch (error) {
        print(error);
      }
    } else {
      print('Not logged in');
    }
  }

  Future<List<Map<String, dynamic>>> getPost(int postId) {
    return supaClient.from(postsTable).select().eq('id', postId);
  }

  void updatePost(int postId, String title, String body) async {
    if (isLoggedin) {
      var test = await supaClient
          .from(postsTable)
          .update({'title': title, 'body': body})
          .eq('id', postId)
          .select();

      print(test.toString());
      notifyListeners();
    } else {
      print('NOT YET LOGGED IN');
    }
  }

  Future<dynamic> deletePost() async {}
}
