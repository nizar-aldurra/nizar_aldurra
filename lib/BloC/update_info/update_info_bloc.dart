import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/repositories/UserRepository.dart';

import '../../models/user.dart';

part 'update_info_event.dart';

part 'update_info_state.dart';

class UpdateInfoBloc extends Bloc<UpdateInfoEvent, UpdateInfoState> {
  UpdateInfoBloc() : super(UpdateInfoInitial()) {
    on<UserNameChanged>(_onUserNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<UpdateButtonPressed>(_onRegisterButtonPressed);
  }

  late String _userName;
  late String _email;
  UserRepository userRepository = UserRepository();

  Future<void> _onUserNameChanged(
      UserNameChanged event, Emitter<UpdateInfoState> emit) async {
    _userName = event.userName;
  }

  Future<void> _onEmailChanged(
      EmailChanged event, Emitter<UpdateInfoState> emit) async {
    _email = event.email;
  }

  Future<void> _onRegisterButtonPressed(
      UpdateButtonPressed event, Emitter<UpdateInfoState> emit) async {
    try {
      dynamic updateResponse =
          await userRepository.UpdateInfo(_userName, _email);
      emit(UpdateInfoLoading());

      if (updateResponse.runtimeType == String) {
        emit(UpdateInfoFailure(updateResponse));
        return;
      } else {
        if (updateResponse.runtimeType != User) {
          emit(UpdateInfoFailure('error'));
          return;
        }
        emit(UpdateInfoSuccess());
      }
    } catch (error) {
      print(error.toString());
      emit(UpdateInfoFailure('Connection Error'));
    }
  }
}
