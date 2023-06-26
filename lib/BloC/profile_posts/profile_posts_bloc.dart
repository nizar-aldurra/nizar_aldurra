import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/repositories/UserRepository.dart';

import '../../models/post.dart';

part 'profile_posts_event.dart';
part 'profile_posts_state.dart';

class ProfilePostsBloc extends Bloc<ProfilePostsEvent, ProfilePostsState> {
  ProfilePostsBloc() : super(ProfilePostsInitial()) {

    on<ProfilePostsLoad>(_onProfilePostsLoad);
  }

  late List _posts;
  UserRepository userRepository = UserRepository();
  Future<void> _onProfilePostsLoad(ProfilePostsLoad event, Emitter<ProfilePostsState> emit) async {
    emit(ProfilePostsLoading());
    try{
      var t = await userRepository.getProfilePosts();
      print('$t');
      if (t == null) {
        emit(ProfilePostsFailure('No Posts'));
        print('null returned');
      } else {
        try {
          final List<Post> posts =
          (t['data']).map<Post>((e) => Post.fromMap(e)).toList();
          posts.sort((post1,post2){
            return post2.publishedAt!.compareTo(post1.publishedAt!);
          });
          emit(ProfilePostsSuccess(posts));
        } catch (error) {
          print(error.toString());
          emit(ProfilePostsFailure('No Posts'));
        }
      }
    }catch(error){
      print(error.toString());
      emit(ProfilePostsFailure("Connection Error"));
    }
  }

}
