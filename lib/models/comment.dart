class Comment{
  String? id;
  String body;
  String postId;

  Comment({this.id,required this.body,required this.postId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': body,
      'post_id': postId,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      body: map['body'] as String,
      postId: map['post_id'] as String,
    );
  }
}