class PostImagesModel {
  final int postImageId;
  final int postId;
  final String createdAt;
  final String publicUrl;
  final String bucketPath;

  const PostImagesModel({
    required this.postImageId,
    required this.postId,
    required this.createdAt,
    required this.publicUrl,
    required this.bucketPath,
  });
}
