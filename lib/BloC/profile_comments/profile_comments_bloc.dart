import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/repositories/UserRepository.dart';

import '../../models/comment.dart';

part 'profile_comments_event.dart';
part 'profile_comments_state.dart';

class ProfileCommentsBloc extends Bloc<ProfileCommentsEvent, ProfileCommentsState> {
  ProfileCommentsBloc() : super(ProfileCommentsInitial()) {
    on<ProfileCommentsLoad>(_onProfileCommentsLoad);
  }
  late List _comments;
  UserRepository userRepository = UserRepository();

  Future<void> _onProfileCommentsLoad(
      ProfileCommentsLoad event, Emitter<ProfileCommentsState> emit) async {
    var t = await userRepository.getProileComments();
    if (t == null) {
      emit(ProfileCommentsFailure('no comments'));
    } else {
      try{
        final List<Comment> comments =
        (t['data']).map<Comment>((e) => Comment.fromMap(e)).toList();
        comments.sort((comment1,comment2){
          return comment2.publishedAt!.compareTo(comment1.publishedAt!);
        });
        emit(ProfileCommentsSuccess(comments));
      }catch(error){
        emit(ProfileCommentsFailure('Connection Error'));
      }
    }
  }
}
