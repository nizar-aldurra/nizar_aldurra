class Comment{
  String? id;
  String body;
  String postId;
  DateTime? publishedAt;

  Comment({this.id,required this.body,required this.postId, this.publishedAt});

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
      publishedAt: DateTime.parse(map['created_at']).toUtc(),
    );
  }
}