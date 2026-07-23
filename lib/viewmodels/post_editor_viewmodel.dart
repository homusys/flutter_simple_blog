import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/services/auth_service.dart';
import 'package:flutter_simple_blog/services/file_service.dart';
import 'package:flutter_simple_blog/services/storage_service.dart';

class PostEditorViewModel extends ChangeNotifier {
  final FileService fileService = FileService();
  final AuthService authService = AuthService();
  final StorageService storageService = StorageService();

  List<PlatformFile>? imagesToUpload;

  bool get hasImagesToUpload =>
      imagesToUpload != null && imagesToUpload!.isNotEmpty;

  String? validateTitle(String? title) {
    return (title != null && title.isEmpty) ? "A title is required" : null;
  }

  Future<void> createPost(String title, String body) async {
    if (!authService.isLoggedIn) {
      return;
    }

    try {
      final post = await authService.supaClient
          .from('posts')
          .insert({
            'title': title,
            'body': body,
            'profile_id': authService.currentUser!.id,
          })
          .select()
          .single();

      final postId = post['id'];

      if (hasImagesToUpload) {
        for (final image in imagesToUpload!) {
          final imageUrl = await storageService.uploadImageToBucket(image);

          await authService.supaClient.from('post_images').insert({
            'post_id': postId,
            'image_url': imageUrl,
          });
        }

        imagesToUpload!.clear();
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updatePost(int postId, String title, String body) async {
    if (!authService.isLoggedIn) {
      return;
    }

    try {
      await authService.supaClient
          .from('posts')
          .update({'title': title, 'body': body})
          .eq('id', 1);
      notifyListeners();
    } catch (error) {
      ///
    }
  }

  /// Calls the file service to pick images asynchronously.
  void selectImages() {
    fileService.getMultipleFiles().then((files) {
      if (files != null) {
        imagesToUpload = files;
      }
      notifyListeners();
    });
  }

  void removeImage() {}
}
