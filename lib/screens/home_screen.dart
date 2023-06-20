import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nizar_aldurra/BloC/authentication/authentication_bloc.dart';
import 'package:nizar_aldurra/BloC/like_post/like_post_bloc.dart';
import 'package:nizar_aldurra/BloC/like_post/like_post_bloc.dart';
import 'package:nizar_aldurra/app/app_data.dart';
import 'package:nizar_aldurra/screens/comments_screen.dart';
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
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Social Media App',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      UserScreen(userId: AppData.userId)),);
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  context.read<AuthenticationBloc>().logout();
                },
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
              child: Text('No Comments'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return postCard(index, posts);
                  }),
            );
          }
        }
        return const Center(
          child: Text('Problem in Server'),
        );
      },
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    UserScreen(userId: posts[index].userId!)),);
              },
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
                  BlocBuilder<LikePostBloc, LikePostState>(
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          context.read<LikePostBloc>().add(ChangeLikingStatus(posts[index].id!));
                          posts[index].isLiked = !posts[index].isLiked;
                        },
                        child: Row(
                          children: [
                            Icon(posts[index].isLiked ? Icons.thumb_up : Icons
                                .thumb_up_alt_outlined),
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
