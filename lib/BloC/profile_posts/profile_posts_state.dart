part of 'profile_posts_bloc.dart';

@immutable
abstract class ProfilePostsState {}

class ProfilePostsInitial extends ProfilePostsState {}

class ProfilePostsLoading extends ProfilePostsState {}

class ProfilePostsSuccess extends ProfilePostsState {
  List<Post> posts;

  ProfilePostsSuccess(this.posts);
}

class ProfilePostsFailure extends ProfilePostsState {
  String error;

  ProfilePostsFailure(this.error);
}