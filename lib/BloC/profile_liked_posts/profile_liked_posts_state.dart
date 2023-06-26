part of 'profile_liked_posts_bloc.dart';

@immutable
abstract class ProfileLikedPostsState {}

class ProfileLikedPostsInitial extends ProfileLikedPostsState {}

class ProfileLikedPostsLoading extends ProfileLikedPostsState {}

class ProfileLikedPostsSuccess extends ProfileLikedPostsState {
  List<Post> posts;

  ProfileLikedPostsSuccess(this.posts);
}

class ProfileLikedPostsFailure extends ProfileLikedPostsState {
  String error;

  ProfileLikedPostsFailure(this.error);
}