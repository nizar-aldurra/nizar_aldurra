part of 'comments_bloc.dart';

@immutable
abstract class CommentsEvent {}

class CommentsStart extends CommentsEvent {}

class CommentsLoad extends CommentsEvent {
  String postId;
  CommentsLoad(this.postId);
}

class CommentsUpdated extends CommentsEvent {
  List comments;

  CommentsUpdated(this.comments);
}