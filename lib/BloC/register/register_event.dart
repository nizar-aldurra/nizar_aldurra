part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {}

class UserNameChanged extends RegisterEvent {
  final String userName;

  UserNameChanged(this.userName);
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged(this.email);
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;

  ConfirmPasswordChanged(this.confirmPassword);
}
