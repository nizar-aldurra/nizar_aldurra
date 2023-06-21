part of 'like_post_bloc.dart';

@immutable
abstract class LikePostEvent {}

class ChangeLikingStatus extends LikePostEvent {
  String postId;

  ChangeLikingStatus(this.postId);
}
