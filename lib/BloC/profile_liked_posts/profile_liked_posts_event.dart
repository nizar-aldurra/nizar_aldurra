part of 'profile_liked_posts_bloc.dart';

@immutable
abstract class ProfileLikedPostsEvent {}
class ProfileLikedPostsLoad extends ProfileLikedPostsEvent {}

class ProfileLikedPostsUpdated extends ProfileLikedPostsEvent {
  List posts;

  ProfileLikedPostsUpdated(this.posts);
}