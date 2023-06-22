import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/models/user.dart';
import 'package:nizar_aldurra/repositories/UserRepository.dart';

import '../../app/app_data.dart';
import '../../models/post.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoad>(_onProfileLoad);
    on<ProfileUpdated>(_onProfileUpdated);
  }

  late List _posts;
  UserRepository userRepository = UserRepository();

  Future<void> _onProfileLoad(
      ProfileLoad event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    // try {
      var t = await userRepository.getUserPosts(event.userId);
      print('$t');
      if (t == null) {
        emit(ProfileFailure('no Posts'));
      } else {
        // try {
          final List<Post> posts =
              (t['data']).map<Post>((e) => Post.fromMap(e)).toList();
          posts.sort((post1,post2){
            return post2.publishedAt!.compareTo(post1.publishedAt!);
          });
          final User user = User.fromMap(t['user']);
          AppData.isAdmin = user.isAdmin!;
          emit(ProfileSuccess(posts, user));
        // } catch (error) {
        //   emit(ProfileFailure('The user was Deleted'));
        // }
      }
    // } catch (error) {
    //   print(error.toString());
    //   emit(ProfileFailure('Connection Error'));
    // }
  }

  Future<void> _onProfileUpdated(
      ProfileUpdated event, Emitter<ProfileState> emit) async {
    _posts = event.posts;
  }
}
