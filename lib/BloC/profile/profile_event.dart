part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}
class ProfileLoad extends ProfileEvent {

  ProfileLoad();
}

class ProfileUpdated extends ProfileEvent {

  ProfileUpdated();
}