import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/app/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../repositories/auth_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<UserNameChanged>(_onUserNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  late String _userName;
  late String _email;
  late String _password;
  late String _confirmPassword;
  AuthRepository authRepository = AuthRepository();

  Future<void> _onUserNameChanged(
      UserNameChanged event, Emitter<RegisterState> emit) async {
    _userName = event.userName;
  }

  Future<void> _onEmailChanged(
      EmailChanged event, Emitter<RegisterState> emit) async {
    _email = event.email;
  }

  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<RegisterState> emit) async {
    _password = event.password;
  }

  Future<void> _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<RegisterState> emit) async {
    _confirmPassword = event.confirmPassword;
  }

  Future<void> _onRegisterButtonPressed(
      RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    try {
      dynamic registerResponse = await authRepository.register(
          _userName, _email, _password, _confirmPassword);
      emit(RegisterLoading());

      if (registerResponse.runtimeType == String) {
        emit(RegisterFailure(registerResponse));
        return;
      } else {
        if (registerResponse.runtimeType != User) {
          emit(RegisterFailure('error'));
          return;
        }
        User user = registerResponse as User;
        user.token = AppData.token;
        Map<String, dynamic> userMap = user.toMap();
        userMap['token'] = AppData.token;
        SharedPreferences.getInstance()
            .then((value) => value.setString('user', jsonEncode(userMap)));
        print('registered succeed');
        emit(RegisterSuccess(user));
      }
    } catch (error) {
      print(error.toString());
      emit(RegisterFailure('Connection Error'));
    }
  }

  set(String name, String email, String password, String confirmPassword) {
    _userName = name;
    _email = email;
    _password = password;
    _confirmPassword = confirmPassword;
  }
}
