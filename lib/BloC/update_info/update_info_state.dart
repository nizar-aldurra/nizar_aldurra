part of 'update_info_bloc.dart';

@immutable
abstract class UpdateInfoState {}

class UpdateInfoInitial extends UpdateInfoState {}

class UpdateInfoLoading extends UpdateInfoState {}

class UpdateInfoSuccess extends UpdateInfoState {}

class UpdateInfoFailure extends UpdateInfoState {
  final String error;

  UpdateInfoFailure(this.error);
}
