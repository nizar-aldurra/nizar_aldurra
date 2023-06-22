import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nizar_aldurra/BloC/deletePost/delete_post_bloc.dart';
import 'package:nizar_aldurra/BloC/profile/profile_bloc.dart';
import 'package:nizar_aldurra/app/app_data.dart';
import 'package:nizar_aldurra/models/post.dart';
import 'package:nizar_aldurra/screens/update_Info_screen.dart';
import 'package:nizar_aldurra/screens/update_Password_screen.dart';
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
        title: userId == AppData.userId
            ? const Text('Your Profile')
            : const Text('User Profile'),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  state.user.name,
                                  style: const TextStyle(fontSize: 25),
                                ),
                                Text(
                                  state.user.email,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                         // IconButton(
                         //        onPressed: () {
                         //          Navigator.of(context).push(
                         //            MaterialPageRoute(
                         //                builder: (context) => UpdateInfoScreen(
                         //                    state.user.name, state.user.email)),
                         //          );
                         //        },
                         //        icon: const Icon(Icons.edit))
                           (userId == AppData.userId || AppData.isAdmin)
                             ?PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem<String>(
                                  value: 'editInfo', child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      Text('Update the information'),
                                    ],
                                  )),
                              const PopupMenuItem<String>(
                                  value: 'editPassword', child: Row(
                                    children: [
                                      Icon(Icons.lock_outline),
                                      Text('update the password'),
                                    ],
                                  )),
                            ];
                          },
                          onSelected: (String value) {
                            if (value == 'editInfo') {
                              Navigator.of(context).push(
                                           MaterialPageRoute(
                                               builder: (context) => UpdateInfoScreen(
                                                   state.user.name, state.user.email)),
                                         );
                            } else if(value == 'editPassword'){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => UpdatePasswordScreen()),
                              );
                            }
                            print(value);
                          },
                          icon: const Icon(Icons.edit),
                        )
                            : const SizedBox(),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  state.user.name,
                                  style: const TextStyle(fontSize: 25),
                                ),
                                Text(
                                  state.user.email,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        (userId == AppData.userId || AppData.isAdmin)
                            ? IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => UpdateInfoScreen(
                                            state.user.name, state.user.email)),
                                  );
                                },
                                icon: const Icon(Icons.edit))
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return postCard(context, index, posts);
                          }),
                    ),
                  ),
                ],
              );
            }
          } else if (state is ProfileFailure) {
            return Center(child: Text(state.error));
          }
          return const Center(
            child: Text('Problem in Connection'),
          );
        },
      ),
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
                  (userId == AppData.userId || AppData.isAdmin)
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
                                        .read<ProfileBloc>()
                                        .add(ProfileLoad(userId));
                                  } else {
                                    context
                                        .read<ProfileBloc>()
                                        .add(ProfileLoad(userId));
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
