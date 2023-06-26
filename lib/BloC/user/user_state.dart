part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  List<Post> posts;
  User user;

  UserSuccess(this.posts, this.user);
}

class UserFailure extends UserState {
  String error;

  UserFailure(this.error);
}
