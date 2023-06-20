import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/models/comment.dart';
import 'package:nizar_aldurra/repositories/posts_repository.dart';

part 'comments_event.dart';

part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsInitial()) {
    on<CommentsLoad>(_onCommentsLoad);
    on<CommentsUpdated>(_onCommentsUpdated);
  }

  late List _comments;
  PostsRepository postsRepository = PostsRepository();

  Future<void> _onCommentsLoad(
      CommentsLoad event, Emitter<CommentsState> emit) async {
    var t = await postsRepository.getPostComments(event.postId);
    if (t == null) {
      emit(CommentsFailure('no comments'));
    } else {
      final List<Comment> comments =
          (t['data']).map<Comment>((e) => Comment.fromMap(e)).toList();
        emit(CommentsSuccess(comments));
    }
  }

  Future<void> _onCommentsUpdated(
      CommentsUpdated event, Emitter<CommentsState> emit) async {
    _comments = event.comments;
  }
}
