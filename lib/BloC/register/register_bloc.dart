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
      emit(RegisterLoading());
      User? user = await authRepository.register(
          _userName, _email, _password, _confirmPassword);

      if (user == null) {
        print('failed to register');
        emit(RegisterInitial());
      } else {
        user.token = AppData.token;
        Map<String, dynamic> userMap = user.toMap();
        userMap['token'] = AppData.token;
        SharedPreferences.getInstance()
            .then((value) => value.setString('user', jsonEncode(userMap)));
        print('registered succeed');
        emit(RegisterSuccess(user));
      }
    } catch (error) {
      print(error);
      emit(RegisterFailure(error.toString()));
    }
  }
}
