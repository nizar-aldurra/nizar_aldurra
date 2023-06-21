import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/models/user.dart';
import 'package:nizar_aldurra/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/app_data.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  late String _email;
  late String _password;
  AuthRepository authRepository = AuthRepository();

  Future<void> _onEmailChanged(
      EmailChanged event, Emitter<LoginState> emit) async {
    _email = event.email;
  }

  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginState> emit) async {
    _password = event.password;
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      print('logging in');
      dynamic loginResponse = await authRepository.login(_email, _password);
      emit(LoginLoading());

      if (loginResponse.runtimeType == String) {
        emit(LoginFailure(loginResponse));
      } else {
        if (loginResponse.runtimeType != User){
          emit(LoginFailure('error'));
        }
        User user = loginResponse as User;
        user.token = AppData.token;
        Map<String, dynamic> userMap = user.toMap();
        userMap['token'] = AppData.token;

        SharedPreferences.getInstance()
            .then((value) => value.setString('user', jsonEncode(userMap)));
        print('login succeed');
        emit(LoginSuccess(user));
      }
    } catch (error) {
      print(error);
      emit(LoginFailure(error.toString()));
    }
  }
}
