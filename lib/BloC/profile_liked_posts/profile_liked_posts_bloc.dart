import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/post.dart';
import '../../repositories/UserRepository.dart';

part 'profile_liked_posts_event.dart';
part 'profile_liked_posts_state.dart';

class ProfileLikedPostsBloc extends Bloc<ProfileLikedPostsEvent, ProfileLikedPostsState> {
  ProfileLikedPostsBloc() : super(ProfileLikedPostsInitial()) {
    on<ProfileLikedPostsLoad>(_onProfileLikedPostsLoad);
  }

  late List _posts;
  UserRepository userRepository = UserRepository();
  Future<void> _onProfileLikedPostsLoad(ProfileLikedPostsLoad event, Emitter<ProfileLikedPostsState> emit) async {
    emit(ProfileLikedPostsLoading());
    try{
      var t = await userRepository.getProfileLikedPosts();
      print('$t');
      if (t == null) {
        emit(ProfileLikedPostsFailure('No Posts'));
        print('null returned');
      } else {
        try {
          final List<Post> posts =
          (t['data']).map<Post>((e) => Post.fromMap(e)).toList();
          posts.sort((post1,post2){
            return post2.publishedAt!.compareTo(post1.publishedAt!);
          });
          emit(ProfileLikedPostsSuccess(posts));
        } catch (error) {
          print(error.toString());
          emit(ProfileLikedPostsFailure('No Posts'));
        }
      }
    }catch(error){
      print(error.toString());
      emit(ProfileLikedPostsFailure("Connection Error"));
    }
  }

}
