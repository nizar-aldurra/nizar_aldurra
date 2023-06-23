import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nizar_aldurra/models/comment.dart';
import 'package:nizar_aldurra/models/user.dart';
import 'package:nizar_aldurra/repositories/UserRepository.dart';

import '../../app/app_data.dart';
import '../../models/post.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserLoad>(_onUserLoad);
    on<UserUpdated>(_onUserUpdated);
  }

  late List _posts;
  UserRepository userRepository = UserRepository();

  Future<void> _onUserLoad(
      UserLoad event, Emitter<UserState> emit) async {
    emit(UserLoading());
    // try {
      var t = await userRepository.getActivities();
      print('$t');
      if (t == null) {
        emit(UserFailure('no Posts'));
      } else {
        // try {
          final List<Post> posts =
              (t['my_posts']).map<Post>((e) => Post.fromMap(e)).toList();
          posts.sort((post1,post2){
            return post2.publishedAt!.compareTo(post1.publishedAt!);
          });
          final User user = User.fromMap(t['user']);
          List<Post> likedPosts = (t['liked_posts']).map<Post>((e) => Post.fromMap(e)).toList();
          likedPosts.sort((post1,post2){
            return post2.publishedAt!.compareTo(post1.publishedAt!);
          });
          List<Comment> comments = (t['comments']).map<Comment>((e) => Comment.fromMap(e)).toList();
          AppData.isAdmin = user.isAdmin!;
          emit(UserSuccess(posts,likedPosts,comments, user));
        // } catch (error) {
        //   emit(UserFailure('The user was Deleted'));
        // }
      }
    // } catch (error) {
    //   print(error.toString());
    //   emit(UserFailure('Connection Error'));
    // }
  }

  Future<void> _onUserUpdated(
      UserUpdated event, Emitter<UserState> emit) async {
    _posts = event.posts;
  }
}
