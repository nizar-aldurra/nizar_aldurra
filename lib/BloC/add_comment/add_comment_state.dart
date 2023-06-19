part of 'add_comment_bloc.dart';

@immutable
abstract class AddCommentState {}
class AddCommentInitial extends AddCommentState {}
class AddCommentLoading extends AddCommentState {}
class AddCommentLoaded extends AddCommentState {
  Comment post;
  AddCommentLoaded(this.post);
}
class AddCommentFailure extends AddCommentState {
  String error;
  AddCommentFailure(this.error);
}
