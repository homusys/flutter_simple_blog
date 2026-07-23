import 'package:flutter_simple_blog/models/comment_images_model.dart';

class CommentModel {
  final int id;
  final String createdAt;
  final String createdBy;
  final int postId;
  final String body;

  final List<CommentImagesModel>? images;

  CommentModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.body,
    required this.postId,
    this.images,
  });
}
