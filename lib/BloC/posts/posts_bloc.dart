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
    // try{
      emit(PostsLoading());
      var t=await postsRepository.getAll();
      print(t);
      final List<Post> posts = (t['data']).map<Post>((e) => Post.fromMap(e)).toList();
      emit(PostsSuccess(posts));
    // } catch(error){
    //   print(error);
    //   emit(PostsFailure(error.toString()));
    // }
  }

  Future<void> _onPostsUpdated(
      PostsUpdated event, Emitter<PostsState> emit) async {
    _posts = event.posts;
  }
}
