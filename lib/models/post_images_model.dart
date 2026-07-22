class PostImagesModel {
  final int postImageId;
  final int postId;
  final String createdAt;
  final String imageUrl;

  const PostImagesModel({
    required this.postImageId,
    required this.postId,
    required this.createdAt,
    required this.imageUrl,
  });
}
