import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/app/app_data.dart';
import 'package:nizar_aldurra/models/user.dart';
import 'package:nizar_aldurra/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

enum AuthenticationStatus {
  loading,
  authenticated,
  unauthenticated,
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationStatus> {
  AuthenticationBloc(AuthenticationStatus initialState) : super(initialState) {
    on<AuthenticationLoggedIn>(_onAuthenticationLoggedIn);
    on<AuthenticationSignedUp>(_onAuthenticationSignedUp);
    on<AuthenticationLoggedOut>(_onAuthenticationLoggedOut);
  }

  Future<void> _onAuthenticationLoggedIn(
      AuthenticationLoggedIn event, Emitter<AuthenticationStatus> emit) async {
    emit(event.user != null
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated);
  }

  Future<void> _onAuthenticationSignedUp(
      AuthenticationSignedUp event, Emitter<AuthenticationStatus> emit) async {
    emit(event.user != null
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated);
  }

  Future<void> _onAuthenticationLoggedOut(
      AuthenticationLoggedOut event, Emitter<AuthenticationStatus> emit) async {
    emit(AuthenticationStatus.unauthenticated);
  }

  loadCashedUser() async {
    var shared = await SharedPreferences.getInstance();

    var userData = shared.getString('user');
    if (userData != null && userData != '-1') {
      User user = User.fromMapFromSharedPreferences(jsonDecode(userData));
      print(user.toString());
      AppData.token = user.token!;
      AppData.userId = user.id!;
      emit(AuthenticationStatus.authenticated);
    } else {
      emit(AuthenticationStatus.unauthenticated);
    }
  }

  logout() async {
    AuthRepository authRepository = AuthRepository();
    authRepository.logout();
    emit(AuthenticationStatus.unauthenticated);
  }
}
