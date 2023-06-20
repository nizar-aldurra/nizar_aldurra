import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nizar_aldurra/BloC/profile/profile_bloc.dart';
import 'package:nizar_aldurra/models/post.dart';

import 'comments_screen.dart';

class UserScreen extends StatefulWidget {
  String userId;

  UserScreen({required this.userId, super.key});

  @override
  State<UserScreen> createState() => _UserScreenState(userId);
}

class _UserScreenState extends State<UserScreen> {
  String userId;

  _UserScreenState(this.userId);

  @override
  void initState() {
    // TODO: implement initState
    context.read<ProfileBloc>().add(ProfileLoad(userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial || state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileSuccess) {
            List<Post> posts = state.posts;
            if (posts.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
                    child: Column(
                      children: [
                        const Text('User Photo',style: TextStyle(fontSize: 35),),
                        const SizedBox(height: 10,),
                        Text(state.user.name,style: const TextStyle(fontSize: 25),),
                        Text(state.user.email,style: const TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('No Comments'),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
                    child: Column(
                      children: [
                        const Text('User Photo',style: TextStyle(fontSize: 35),),
                        const SizedBox(height: 10,),
                        Text(state.user.name,style: const TextStyle(fontSize: 25),),
                        Text(state.user.email,style: const TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return postCard(index, posts);
                          }),
                    ),
                  ),
                ],
              );
            }
          }
          return const Center(
            child: Text('Problem in Server'),
          );
        },
      ),
    );
  }

  Widget postCard(int index, List<Post> posts) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                posts[index].userName!,
                style: const TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            Text(
              posts[index].title,
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              posts[index].publishedAt?.timeZoneName == null
                  ? 'null'
                  : DateFormat('dd/MM/yyyy  hh:mm')
                      .format(posts[index].publishedAt!),
              style: const TextStyle(fontSize: 18),
            ),
            Text(posts[index].body),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(posts[index].isLiked ?Icons.thumb_up : Icons.thumb_up_alt_outlined),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text('Like')
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CommentsScreen.routeName,
                          arguments: {'post_id': posts[index].id});
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.comment),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Comment')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
