part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  List<Post> myPosts;
  List<Post> likedPosts;
  List<Comment> comments;
  User user;

  UserSuccess(this.myPosts,this.likedPosts,this.comments, this.user);
}

class UserFailure extends UserState {
  String error;

  UserFailure(this.error);
}
