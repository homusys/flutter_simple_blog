import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  static const String postImageBucket = 'post_images';

  SupabaseStorageClient get supaStorage => Supabase.instance.client.storage;

  Future<String> uploadImageToBucket(PlatformFile image) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${image.name}';

    await supaStorage.from('post_images').uploadBinary(fileName, image.bytes!);
    return supaStorage.from('post_images').getPublicUrl(fileName);
  }

  Future<List<String>> uploadImagesToBucket(
    List<File> images,
    String bucket,
  ) async {
    final List<String> uploadedFilesPath = [];

    for (final image in images) {
      String path = await supaStorage.from(bucket).upload('file_path', image);

      uploadedFilesPath.add(path);
    }

    return uploadedFilesPath;
  }
}
