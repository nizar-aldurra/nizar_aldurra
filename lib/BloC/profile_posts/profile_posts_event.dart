part of 'profile_posts_bloc.dart';

@immutable
abstract class ProfilePostsEvent {}
class ProfilePostsLoad extends ProfilePostsEvent {}

class ProfilePostsUpdated extends ProfilePostsEvent {
  List posts;

  ProfilePostsUpdated(this.posts);
}
