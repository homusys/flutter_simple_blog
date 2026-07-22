import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';
import 'package:flutter_simple_blog/services/file_service.dart';

class CreatePostViewmodel extends ChangeNotifier {
  final FileService fileService = FileService();
  final AuthService authService = AuthService();

  List<PlatformFile>? filesToUpload;

  bool get hasFilesToUpload =>
      filesToUpload != null && filesToUpload!.isNotEmpty;

  String? validateTitle(String title) {
    return (title.isEmpty) ? "A title is required" : null;
  }

  Future<void> createPost(String title, String body) async {
    if (authService.isLoggedIn) {
      try {
        var test = await authService.supaClient.from('posts').insert({
          'title': title,
          'body': body,
          'profile_id': authService.currentUser!.id,
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

  /// Calls the file service to pick images asynchronously.
  void selectImages() {
    fileService.getMultipleFiles().then((files) {
      filesToUpload = files;
      notifyListeners();
    });
  }

  void removeImage() {}
}
