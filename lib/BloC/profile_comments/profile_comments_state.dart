part of 'profile_comments_bloc.dart';

@immutable
abstract class ProfileCommentsState {}

class ProfileCommentsInitial extends ProfileCommentsState {}

class ProfileCommentsLoading extends ProfileCommentsState {}

class ProfileCommentsSuccess extends ProfileCommentsState {
  List<Comment> comment;

  ProfileCommentsSuccess(this.comment);
}

class ProfileCommentsFailure extends ProfileCommentsState {
  String error;

  ProfileCommentsFailure(this.error);
}
