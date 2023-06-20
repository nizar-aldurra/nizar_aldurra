part of 'like_post_bloc.dart';

@immutable
abstract class LikePostState {}

class LikePostInitial extends LikePostState {}

class LikePostLoading extends LikePostState {}

class LikePostSuccess extends LikePostState {
  bool isLiked ;
  LikePostSuccess(this.isLiked);
}

class LikePostFailure extends LikePostState {
  String error;

  LikePostFailure(this.error);
}
