import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/posts_repository.dart';

part 'like_post_event.dart';
part 'like_post_state.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  LikePostBloc() : super(LikePostInitial()) {
    on<ChangeLikingStatus>(_onChangeLikingStatus);
  }
  PostsRepository postsRepository = PostsRepository();
  Future<void> _onChangeLikingStatus(
      ChangeLikingStatus event, Emitter<LikePostState> emit) async {
    var t = await postsRepository.changeLikingStatus(event.postId);
    print(t);
    if (t == null) {
      emit(LikePostFailure('no comments'));
    } else {
      emit(LikePostSuccess(t['isLiked'] as bool));
    }
  }
}
