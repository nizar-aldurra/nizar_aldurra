import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/models/comment.dart';
import 'package:nizar_aldurra/repositories/comments_repository.dart';
import 'package:nizar_aldurra/repositories/posts_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsInitial()) {
    on<CommentsLoad>(_onCommentsLoad);
    on<CommentsUpdated>(_onCommentsUpdated);
  }
  late List _comments;
  PostsRepository postsRepository= PostsRepository();

  Future<void> _onCommentsLoad(CommentsLoad event, Emitter<CommentsState> emit) async {
    // try{
    print('hi');
    var t=await postsRepository.getPostComments(event.postId);
    if(t== null){
      emit(CommentsFailure('no comments'));
    }else {
      final List<Comment> comments =
          (t['data']).map<Comment>((e) => Comment.fromMap(e)).toList();
      if (comments.isEmpty) {
        emit(CommentsFailure('no comments'));
      } else {
        emit(CommentsSuccess(comments));
      }
    }
    // } catch(error){
    //   print(error);
    //   emit(PostsFailure(error.toString()));
    // }
  }

  Future<void> _onCommentsUpdated(
      CommentsUpdated event, Emitter<CommentsState> emit) async {
    _comments = event.comments;
  }
}
