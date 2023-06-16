part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class PostsLoad extends PostsEvent {}

class PostsUpdated extends PostsEvent {
  List posts;

  PostsUpdated(this.posts);
}
