import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/models/user.dart';
import 'package:nizar_aldurra/repositories/UserRepository.dart';

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

  Future<void> _onProfileLoad(ProfileLoad event, Emitter<ProfileState> emit) async {
    // try{
    emit(ProfileLoading());
    var t = await userRepository.getUserPosts(event.userId);
    print('$t');
    if (t == null) {
      emit(ProfileFailure('no comments'));
    } else {
      final List<Post> posts =
      (t['data']).map<Post>((e) => Post.fromMap(e)).toList();
      final User user = User.fromMap(t['user']);
      print('$user ${t['user']}');
      emit(ProfileSuccess(posts,user));
    }
  }

  Future<void> _onProfileUpdated(
      ProfileUpdated event, Emitter<ProfileState> emit) async {
    _posts = event.posts;
  }
}
