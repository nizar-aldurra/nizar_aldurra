part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileLoad extends ProfileEvent {
  String userId;
  ProfileLoad(this.userId);
}

class ProfileUpdated extends ProfileEvent {
  List<Post> posts;

  ProfileUpdated(this.posts);
}