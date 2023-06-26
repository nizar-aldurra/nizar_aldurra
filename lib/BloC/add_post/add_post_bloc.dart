import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nizar_aldurra/repositories/posts_repository.dart';

import '../../models/post.dart';

part 'add_post_event.dart';

part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<TitlePostChanged>(_onTitlePostChanged);
    on<BodyPostChanged>(_onBodyPostChanged);
    on<ImagesPostChanged>(_onImagesPostChanged);
    on<AddPostButtonPressed>(_onAddPostButtonPressed);
  }

  late String _title;
  late String _body;
  late List<XFile> _images;
  PostsRepository postsRepository = PostsRepository();

  Future<void> _onTitlePostChanged(
      TitlePostChanged event, Emitter<AddPostState> emit) async {
    _title = event.title;
  }

  Future<void> _onBodyPostChanged(
      BodyPostChanged event, Emitter<AddPostState> emit) async {
    _body = event.body;
  }
  Future<void> _onImagesPostChanged(
      ImagesPostChanged event, Emitter<AddPostState> emit) async {
    _images = event.images;
  }

  Future<void> _onAddPostButtonPressed(
      AddPostButtonPressed event, Emitter<AddPostState> emit) async {
    try {
      emit(AddPostLoading());
      Post post = Post(title: _title, body: _body,images: _images);
      var response = await postsRepository.storePost(post);
      if (response == null) {
        print('failed to add post');
      } else {
        emit(AddPostLoaded());
      }
    } catch (error) {
      print(error);
      emit(AddPostFailure(error.toString()));
    }
  }
}
