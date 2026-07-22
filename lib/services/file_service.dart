import 'package:file_picker/file_picker.dart';

/// This class is used for getting files from the filesystem.
class FileService {
  const FileService();
  Future<List<PlatformFile>?> getMultipleFiles() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true,
    );
    if (result != null) {
      return result.files.map((e) => e).toList();
    }

    // User canceled the action.
    return null;
  }
}
