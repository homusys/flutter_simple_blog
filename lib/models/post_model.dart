import 'package:flutter_simple_blog/models/post_images_model.dart';

class PostModel {
  final int postId;
  final String createdAt;
  final String createdBy;
  final String title;
  final String body;

  final List<PostImagesModel>? images;

  PostModel({
    required this.postId,
    required this.createdAt,
    required this.createdBy,
    required this.title,
    this.images,
    this.body = '',
  });
}
