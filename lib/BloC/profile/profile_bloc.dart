import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';
import '../../repositories/UserRepository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoad>(_onProfileLoad);
    // on<ProfileUpdated>(_onProfileUpdated);
  }

  late List _posts;
  UserRepository userRepository = UserRepository();

  Future<void> _onProfileLoad(
      ProfileLoad event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    // try {
    var t = await userRepository.getProfileInfo();
    print('$t');
    if (t == null) {
      emit(ProfileFailure('no Posts'));
    } else {
      // try {
      final int postsNum =t['postsNum'];
      final int commentsNum =t['commentsNum'];
      final int likesNum =t['likesNum'];
      final User user = User.fromMap(t['user']);
      emit(ProfileSuccess(postsNum,commentsNum,likesNum, user));
      // } catch (error) {
      //   emit(UserFailure('The user was Deleted'));
      // }
    }
    // } catch (error) {
    //   print(error.toString());
    //   emit(UserFailure('Connection Error'));
    // }
  }
}
