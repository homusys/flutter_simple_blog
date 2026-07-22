import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  static const String postImageBucket = 'post_images';

  SupabaseStorageClient get supaStorage => Supabase.instance.client.storage;

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
