part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsSuccess extends PostsState {
  List<Post> posts;
  PostsSuccess(this.posts);
}

class PostsFailure extends PostsState {
  String error;

  PostsFailure(this.error);
}
