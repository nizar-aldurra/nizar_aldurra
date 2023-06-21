part of 'delete_post_bloc.dart';

@immutable
abstract class DeletePostEvent {}

class DeletePost extends DeletePostEvent{
  String postId;
  DeletePost(this.postId);
}