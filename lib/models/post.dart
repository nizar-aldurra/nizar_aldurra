import 'package:image_picker/image_picker.dart';

class Post {
  String? id;
  String? userId;
  String? userName;
  String title;
  String body;
  List<XFile>? images;
  List<dynamic>? imageURLs;
  int? likesNum;
  int? commentsNum;
  bool isLiked;
  DateTime? publishedAt;

  Post({
    this.id,
    this.userId,
    this.userName,
    required this.title,
    required this.body,
    this.publishedAt,
    this.isLiked = false,
    this.commentsNum,
    this.likesNum,
    this.images,
    this.imageURLs,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }

  @override
  toString() {
    return '{title : $title , body: $body}';
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'].toString(),
      userId: map['user_id'].toString(),
      userName: map['user_name'].toString(),
      title: map['title'].toString(),
      body: map['body'].toString(),
      isLiked: map['is_liked'] as bool,
      likesNum: map['likes'] as int,
      commentsNum: map['comments'] as int,
      imageURLs: map['images'],
      publishedAt: DateTime.parse(map['created_at']).toLocal(),
    );
  }
}
