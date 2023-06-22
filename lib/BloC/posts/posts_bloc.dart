import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/models/post.dart';
import 'package:nizar_aldurra/repositories/posts_repository.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsLoad>(_onPostsLoad);
    on<PostsUpdated>(_onPostsUpdated);
  }

  late List _posts;
  PostsRepository postsRepository = PostsRepository();

  Future<void> _onPostsLoad(PostsLoad event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    try{
      var t = await postsRepository.getAll();
      print('$t');
      if (t == null) {
        emit(PostsFailure('No Posts'));
      } else {
        try {
          final List<Post> posts =
              (t['data']).map<Post>((e) => Post.fromMap(e)).toList();
          posts.sort((post1,post2){
            return post2.publishedAt!.compareTo(post1.publishedAt!);
          });
          emit(PostsSuccess(posts));
        } catch (error) {
          emit(PostsFailure('No Posts'));
        }
      }
    }catch(error){
      emit(PostsFailure("Connection Error"));
    }
  }

  Future<void> _onPostsUpdated(
      PostsUpdated event, Emitter<PostsState> emit) async {
    _posts = event.posts;
  }
}
