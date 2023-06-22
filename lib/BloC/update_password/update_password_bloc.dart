import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/UserRepository.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordBloc() : super(UpdatePasswordInitial()) {
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<CurrentPasswordChanged>(_onCurrentPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<UpdateButtonPressed>(_onUpdateButtonPressed);
  }

  late String _newPassword;
  late String _confirmPassword;
  late String _currentPassword;
  UserRepository userRepository = UserRepository();

  Future<void> _onNewPasswordChanged(
      NewPasswordChanged event, Emitter<UpdatePasswordState> emit) async {
    _newPassword = event.password;
  }

  Future<void> _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<UpdatePasswordState> emit) async {
    _confirmPassword = event.confirmPassword;
  }
  Future<void> _onCurrentPasswordChanged(
      CurrentPasswordChanged event, Emitter<UpdatePasswordState> emit) async {
    _currentPassword = event.password;
  }

  Future<void> _onUpdateButtonPressed(
      UpdateButtonPressed event, Emitter<UpdatePasswordState> emit) async {
    try {
      emit(UpdatePasswordLoading());
      bool updated =
      await userRepository.updatePassword(_currentPassword,_newPassword);

      if (updated == false) {
        print('failed to update');
        emit(UpdatePasswordFailure('failed to update'));
      } else {
        print('Updated');
        emit(UpdatePasswordSuccess());
      }
    } catch (error) {
      print(error);
      emit(UpdatePasswordFailure(error.toString()));
    }
  }

}
