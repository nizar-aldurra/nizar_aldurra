part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  AuthenticationLoggedIn(this.user);

  final User? user;
}

class AuthenticationSignedUp extends AuthenticationEvent {
  AuthenticationSignedUp(this.user);

  final User? user;
}

class AuthenticationLoggedOut extends AuthenticationEvent {}
