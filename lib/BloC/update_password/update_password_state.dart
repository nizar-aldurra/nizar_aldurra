part of 'update_password_bloc.dart';

@immutable
abstract class UpdatePasswordState {}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordLoading extends UpdatePasswordState {}

class UpdatePasswordSuccess extends UpdatePasswordState {}

class UpdatePasswordFailure extends UpdatePasswordState {
  final String error;

  UpdatePasswordFailure(this.error);
}