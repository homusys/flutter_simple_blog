class CommentModel {
  final int id;
  final String createdAt;
  final String createdBy;
  final int postId;
  final String body;

  const CommentModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.body,
    required this.postId,
  });
}
