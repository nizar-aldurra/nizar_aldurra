part of 'update_info_bloc.dart';

@immutable
abstract class UpdateInfoEvent {}

class UserNameChanged extends UpdateInfoEvent {
  final String userName;

  UserNameChanged(this.userName);
}

class EmailChanged extends UpdateInfoEvent {
  final String email;

  EmailChanged(this.email);
}


class UpdateButtonPressed extends UpdateInfoEvent {}
