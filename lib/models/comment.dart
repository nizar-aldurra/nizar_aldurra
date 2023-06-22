class Comment {
  String? id;
  String body;
  String postId;
  String? userId;
  String? userName;
  DateTime? publishedAt;

  Comment({
    this.id,
    required this.body,
    required this.postId,
    this.publishedAt,
    this.userId,
    this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'post_id': postId,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'].toString(),
      body: map['body'] as String,
      postId: map['post_id'].toString(),
      userId: map['user_id'].toString(),
      userName: map['user_name'].toString(),
      publishedAt: DateTime.parse(map['created_at']).toLocal(),
    );
  }
}
