import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nizar_aldurra/BloC/authentication/authentication_bloc.dart';
import 'package:nizar_aldurra/BloC/deletePost/delete_post_bloc.dart';
import 'package:nizar_aldurra/BloC/like_post/like_post_bloc.dart';
import 'package:nizar_aldurra/app/app_data.dart';
import 'package:nizar_aldurra/screens/comments_screen.dart';
import 'package:nizar_aldurra/screens/profile_screen.dart';
import 'package:nizar_aldurra/screens/user_screen.dart';
import '../BloC/posts/posts_bloc.dart';
import '../models/post.dart';
import '../screens/add_post_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home_Page';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          centerTitle: true,
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPostScreen.routeName);
              },
              icon: const Icon(Icons.add),
              label: const Text('New Post'),
              style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
            ),
          ],
        ),
        body: const PostsWidget(),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: Theme.of(context).primaryColor,
                child: const Center(
                  child: Text(
                    'Social Media App',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(ProfileScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    context.read<AuthenticationBloc>().logout();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostsWidget extends StatefulWidget {
  const PostsWidget({
    super.key,
  });

  @override
  State<PostsWidget> createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<PostsBloc>().add(PostsLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsInitial || state is PostsLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is PostsSuccess) {
          List<Post> posts = state.posts;
          if (posts.isEmpty) {
            return const Center(
              child: Text('No Posts'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return postCard(context, index, posts);
                  }),
            );
          }
        }
        return const Center(
          child: Text('Problem in Connection'),
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
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserScreen(userId: posts[index].userId!)),
                            );
                          },
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
                                child: Column(
                                  children: [
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                      ],
                                    ),
                                    Text(posts[index].body),
                                  ],
                                ),
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
                                    context.read<PostsBloc>().add(PostsLoad());
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
                    children: [
                      BlocBuilder<LikePostBloc, LikePostState>(
                        builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              context
                                  .read<LikePostBloc>()
                                  .add(ChangeLikingStatus(posts[index].id!));
                              setState(() {
                                if (posts[index].isLiked == true) {
                                  posts[index].likesNum =
                                      posts[index].likesNum! - 1;
                                } else {
                                  posts[index].likesNum =
                                      posts[index].likesNum! + 1;
                                }
                              });
                              posts[index].isLiked = !posts[index].isLiked;
                            },
                            child: Row(
                              children: [
                                Icon(posts[index].isLiked
                                    ? Icons.thumb_up
                                    : Icons.thumb_up_alt_outlined),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text('Like'),
                              ],
                            ),
                          );
                        },
                      ),
                      const Expanded(child: SizedBox()),
                      TextButton(
                        onPressed: () async{
                          dynamic commentsNum= await Navigator.of(context).pushNamed(
                              CommentsScreen.routeName,
                              arguments: {'post_id': posts[index].id,'commentsNum':posts[index].commentsNum});
                          setState(() {
                            if(commentsNum != null && commentsNum.runtimeType == int){
                              print(commentsNum);
                              posts[index].commentsNum=commentsNum;
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
