part of '../login/login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState{}

class LoginSuccess extends LoginState{
  User user;
  LoginSuccess(this.user);
}

class LoginFailure extends LoginState{
  final String error;

  LoginFailure(this.error);
}
