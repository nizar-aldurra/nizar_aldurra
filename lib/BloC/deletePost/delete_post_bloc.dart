import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/repositories/posts_repository.dart';

part 'delete_post_event.dart';
part 'delete_post_state.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  DeletePostBloc() : super(DeletePostInitial()) {
    on<DeletePost>((event, emit) {
      postsRepository.deleteData(event.postId);
    });
  }
  PostsRepository postsRepository = PostsRepository();
}
