part of 'profile_comments_bloc.dart';

@immutable
abstract class ProfileCommentsEvent {}
class ProfileCommentsLoad extends ProfileCommentsEvent {

  ProfileCommentsLoad();
}