import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nizar_aldurra/screens/user_screen.dart';

import '../BloC/deletePost/delete_post_bloc.dart';
import '../BloC/like_post/like_post_bloc.dart';
import '../BloC/profile_posts/profile_posts_bloc.dart';
import '../app/app_data.dart';
import '../models/post.dart';
import 'comments_screen.dart';

class ProfilePostsScreen extends StatefulWidget {
  static String routeName = 'profile_posts_screen';

  const ProfilePostsScreen({super.key});

  @override
  State<ProfilePostsScreen> createState() => _ProfilePostsScreenState();
}

class _ProfilePostsScreenState extends State<ProfilePostsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ProfilePostsBloc>().add(ProfilePostsLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePostsBloc, ProfilePostsState>(
      builder: (context, state) {
        if (state is ProfilePostsInitial || state is ProfilePostsLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is ProfilePostsSuccess) {
          List<Post> posts = state.posts;
          if (posts.isEmpty) {
            return const Scaffold(
              body: Center(
                child: Text('No Posts'),
              ),
            );
          } else {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return postCard(context, index, posts);
                    }),
              ),
            );
          }
        }
        return const Scaffold(
          body: Center(
            child: Text('Problem in Connection'),
          ),
        );
      },
    );
  }

  Widget postCard(BuildContext context, int index, List<Post> posts) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            posts[index].userName!,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                posts[index].title,
                                style: const TextStyle(fontSize: 22),
                              ),
                              Text(
                                posts[index].publishedAt?.timeZoneName == null
                                    ? 'null'
                                    : DateFormat('dd/MM/yyyy  HH:mm:a')
                                        .format(posts[index].publishedAt!),
                                style: const TextStyle(fontSize: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(posts[index].body),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppData.isAdmin
                      ? BlocProvider(
                          create: (context) => DeletePostBloc(),
                          child: BlocBuilder<DeletePostBloc, DeletePostState>(
                            builder: (context, state) {
                              return PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem<String>(
                                        value: 'delete', child: Text('Delete')),
                                  ];
                                },
                                onSelected: (String value) {
                                  if (value == 'delete') {
                                    context
                                        .read<DeletePostBloc>()
                                        .add(DeletePost(posts[index].id!));
                                    context
                                        .read<ProfilePostsBloc>()
                                        .add(ProfilePostsLoad());
                                  }
                                  print(value);
                                },
                                icon: const Icon(Icons.more_vert),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                ]),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${posts[index].likesNum} likes'),
                      Text('${posts[index].commentsNum} comments'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          dynamic commentsNum = await Navigator.of(context)
                              .pushNamed(CommentsScreen.routeName, arguments: {
                            'post_id': posts[index].id,
                            'commentsNum': posts[index].commentsNum
                          });
                          setState(() {
                            if (commentsNum != null &&
                                commentsNum.runtimeType == int) {
                              print(commentsNum);
                              posts[index].commentsNum = commentsNum;
                            }
                          });
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
