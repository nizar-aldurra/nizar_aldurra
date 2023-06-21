part of 'delete_post_bloc.dart';

@immutable
abstract class DeletePostState {}

class DeletePostInitial extends DeletePostState {}
class DeletePostLoading extends DeletePostState {}
class DeletePostSuccess extends DeletePostState {}
class DeletePostFailure extends DeletePostState {}
