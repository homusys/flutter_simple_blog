class CommentImagesModel {
  final int id;
  final int commentId;
  final String createdAt;
  final String bucketPath;
  final String publicUrl;

  const CommentImagesModel({
    required this.id,
    required this.createdAt,
    required this.commentId,
    required this.bucketPath,
    required this.publicUrl,
  });
}
