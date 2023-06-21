part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileEvent {}

class UserNameChanged extends UpdateProfileEvent {
  final String userName;

  UserNameChanged(this.userName);
}

class EmailChanged extends UpdateProfileEvent {
  final String email;

  EmailChanged(this.email);
}

class PasswordChanged extends UpdateProfileEvent {
  final String password;

  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends UpdateProfileEvent {
  final String confirmPassword;

  ConfirmPasswordChanged(this.confirmPassword);
}

class RegisterButtonPressed extends UpdateProfileEvent {}
