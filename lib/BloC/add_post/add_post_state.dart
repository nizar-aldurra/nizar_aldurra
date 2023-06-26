part of 'add_post_bloc.dart';

@immutable
abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostLoaded extends AddPostState {
}

class AddPostFailure extends AddPostState {
  String error;
  AddPostFailure(this.error);
}
