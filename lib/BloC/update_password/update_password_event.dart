part of 'update_password_bloc.dart';

@immutable
abstract class UpdatePasswordEvent {}

class CurrentPasswordChanged extends UpdatePasswordEvent {
  final String password;

  CurrentPasswordChanged(this.password);
}
class NewPasswordChanged extends UpdatePasswordEvent {
  final String password;

  NewPasswordChanged(this.password);
}

class ConfirmPasswordChanged extends UpdatePasswordEvent {
  final String confirmPassword;

  ConfirmPasswordChanged(this.confirmPassword);
}


class UpdateButtonPressed extends UpdatePasswordEvent {}