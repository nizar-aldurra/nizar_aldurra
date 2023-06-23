import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';
import '../../repositories/UserRepository.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordBloc() : super(UpdatePasswordInitial()) {
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<CurrentPasswordChanged>(_onCurrentPasswordChanged);
    on<UpdateButtonPressed>(_onUpdateButtonPressed);
  }

  late String _newPassword;
  late String _currentPassword;
  UserRepository userRepository = UserRepository();

  Future<void> _onNewPasswordChanged(
      NewPasswordChanged event, Emitter<UpdatePasswordState> emit) async {
    _newPassword = event.password;
  }
  Future<void> _onCurrentPasswordChanged(
      CurrentPasswordChanged event, Emitter<UpdatePasswordState> emit) async {
    _currentPassword = event.password;
  }

  Future<void> _onUpdateButtonPressed(
      UpdateButtonPressed event, Emitter<UpdatePasswordState> emit) async {
    try {
      print('$_currentPassword $_newPassword');
      dynamic updateResponse =
      await userRepository.updatePassword(_currentPassword,_newPassword);
      emit(UpdatePasswordLoading());
      if (updateResponse.runtimeType == String) {
        emit(UpdatePasswordFailure(updateResponse));
        return;
      } else {
        if (updateResponse.runtimeType != User) {
          emit(UpdatePasswordSuccess());
          return;
        }
        emit(UpdatePasswordSuccess());
      }
    } catch (error) {
      print(error);
      emit(UpdatePasswordFailure('Connection error'));
    }
  }

}
