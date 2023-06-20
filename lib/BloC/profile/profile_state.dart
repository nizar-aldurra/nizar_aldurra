part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  List<Post> posts;
  User user;

  ProfileSuccess(this.posts,this.user);
}

class ProfileFailure extends ProfileState {
  String error;

  ProfileFailure(this.error);
}
