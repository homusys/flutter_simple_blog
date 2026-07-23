import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/viewmodels/post_editor_viewmodel.dart';
import 'package:provider/provider.dart';

class ImageUploadField extends StatelessWidget {
  const ImageUploadField({super.key});

  Widget showImagesToUpload(PostEditorViewModel vm) {
    if (!vm.hasImagesToUpload) {
      return SizedBox.shrink();
    }

    return SizedBox(
      height: 80,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final file in vm.imagesToUpload!)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.memory(file.bytes!, width: 80, height: 80),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostEditorViewModel>(
      builder: (context, viewModel, child) => Column(
        children: [
          showImagesToUpload(viewModel),
          TextButton(
            onPressed: () {
              viewModel.selectImages();
            },
            child: Text("Upload images"),
          ),
        ],
      ),
    );
  }
}
