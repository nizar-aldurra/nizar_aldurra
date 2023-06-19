part of 'add_comment_bloc.dart';

@immutable
abstract class AddCommentEvent {}
class BodyCommentChanged extends AddCommentEvent{
  final String newComment;
  BodyCommentChanged(this.newComment);
}
class AddCommentButtonPressed extends AddCommentEvent{
  String id;
  AddCommentButtonPressed(this.id);
}
