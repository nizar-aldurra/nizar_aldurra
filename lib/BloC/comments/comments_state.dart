part of 'comments_bloc.dart';

@immutable
abstract class CommentsState {}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {}

class CommentsSuccess extends CommentsState {
  List<Comment> comment;

  CommentsSuccess(this.comment);
}

class CommentsFailure extends CommentsState {
  String error;

  CommentsFailure(this.error);
}
