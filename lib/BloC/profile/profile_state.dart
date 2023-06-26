part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}


class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  int postsNum,commentsNum,likesNum;
  User user;

  ProfileSuccess(this.postsNum,this.commentsNum,this.likesNum, this.user);
}

class ProfileFailure extends ProfileState {
  String error;

  ProfileFailure(this.error);
}
