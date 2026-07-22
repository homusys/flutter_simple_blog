class PostModel {
  final int postId;
  final String createdAt;
  final String createdBy;
  final String title;
  final String body;

  final List<String>? imageUrls;

  PostModel({
    required this.postId,
    required this.createdAt,
    required this.createdBy,
    required this.title,
    this.imageUrls,
    this.body = 'Sample Body',
  });
}
