class Post {
  String? id;
  String? userId;
  String title;
  String body;
  DateTime? publishedAt;

  Post({this.id, this.userId,required this.title,required this.body, this.publishedAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'body': body,
      'published_at': publishedAt,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'].toString(),
      userId: map['user_id'].toString(),
      title: map['title'] as String,
      body: map['body'] as String,
      publishedAt: DateTime.parse(map['created_at']).toUtc(),
    );
  }
}