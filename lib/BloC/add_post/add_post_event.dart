part of 'add_post_bloc.dart';

@immutable
abstract class AddPostEvent {}

class TitlePostChanged extends AddPostEvent {
  final String title;

  TitlePostChanged(this.title);
}

class BodyPostChanged extends AddPostEvent {
  final String body;

  BodyPostChanged(this.body);
}

class ImagesPostChanged extends AddPostEvent {
  final List<XFile> images;

  ImagesPostChanged(this.images);
}

class AddPostButtonPressed extends AddPostEvent {}
