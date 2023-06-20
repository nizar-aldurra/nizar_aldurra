import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/repositories/comments_repository.dart';

import '../../models/comment.dart';

part 'add_comment_event.dart';

part 'add_comment_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  AddCommentBloc() : super(AddCommentInitial()) {
    on<BodyCommentChanged>(_onBodyCommentChanged);
    on<AddCommentButtonPressed>(_onAddCommentButtonPressed);
  }

  late String _title;
  late String _newComment;
  CommentsRepository commentsRepository = CommentsRepository();

  Future<void> _onBodyCommentChanged(
      BodyCommentChanged event, Emitter<AddCommentState> emit) async {
    _newComment = event.newComment;
  }

  Future<void> _onAddCommentButtonPressed(
      AddCommentButtonPressed event, Emitter<AddCommentState> emit) async {
    try {
      emit(AddCommentLoading());
      Comment comment = Comment(body: _newComment, postId: event.id);
      var response = await commentsRepository.storeData(comment);
      if (response == null) {
        print('failed to add comment');
      } else {
        print(response);
        Comment comment = Comment.fromMap(response['data']);
        emit(AddCommentLoaded(comment));
      }
    } catch (error) {
      print(error);
      emit(AddCommentFailure(error.toString()));
    }
  }
}
