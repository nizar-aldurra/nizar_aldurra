part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserLoad extends UserEvent {
  String userId;

  UserLoad(this.userId);
}

class UserUpdated extends UserEvent {
  List<Post> posts;

  UserUpdated(this.posts);
}
