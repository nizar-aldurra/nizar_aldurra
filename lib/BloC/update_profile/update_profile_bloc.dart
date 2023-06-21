import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/repositories/UserRepository.dart';

import '../../models/user.dart';

part 'update_profile_event.dart';

part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<UserNameChanged>(_onUserNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  late String _userName;
  late String _email;
  String _password = '';
  String _confirmPassword = '';
  UserRepository userRepository = UserRepository();

  Future<void> _onUserNameChanged(
      UserNameChanged event, Emitter<UpdateProfileState> emit) async {
    _userName = event.userName;
  }

  Future<void> _onEmailChanged(
      EmailChanged event, Emitter<UpdateProfileState> emit) async {
    _email = event.email;
  }

  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<UpdateProfileState> emit) async {
    _password = event.password;
  }

  Future<void> _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<UpdateProfileState> emit) async {
    _confirmPassword = event.confirmPassword;
  }

  Future<void> _onRegisterButtonPressed(
      RegisterButtonPressed event, Emitter<UpdateProfileState> emit) async {
    try {
      emit(UpdateProfileLoading());
      if (_password != _confirmPassword) {
        return;
      }
      bool updated =
          await userRepository.updateUser(_userName, _email, _password);

      if (updated == false) {
        print('failed to update');
        emit(UpdateProfileInitial());
      } else {
        print('Updated');
        emit(UpdateProfileSuccess());
      }
    } catch (error) {
      print(error);
      emit(UpdateProfileFailure(error.toString()));
    }
  }
}
