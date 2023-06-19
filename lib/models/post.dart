class Post {
  String? id;
  String? userId;
  String title;
  String body;
  DateTime? publishedAt;

  Post({this.id, this.userId,required this.title,required this.body, this.publishedAt});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }
  @override
  toString(){
    return '{title : $title , body: $body}';
}

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'].toString(),
      userId: map['user_id'].toString(),
      title: map['title'].toString(),
      body: map['body'].toString(),
      publishedAt: DateTime.parse(map['created_at']).toUtc(),
    );
  }
}