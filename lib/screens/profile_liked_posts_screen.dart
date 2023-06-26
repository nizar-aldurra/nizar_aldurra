import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nizar_aldurra/BloC/profile_liked_posts/profile_liked_posts_bloc.dart';
import 'package:nizar_aldurra/screens/user_screen.dart';

import '../BloC/deletePost/delete_post_bloc.dart';
import '../BloC/like_post/like_post_bloc.dart';
import '../app/app_data.dart';
import '../models/post.dart';
import 'comments_screen.dart';
class ProfileLikedPostsScreen extends StatefulWidget {
  static String routeName='profile_liked_posts_screen';

  const ProfileLikedPostsScreen({super.key});

  @override
  State<ProfileLikedPostsScreen> createState() => _ProfileLikedPostsScreenState();
}

class _ProfileLikedPostsScreenState extends State<ProfileLikedPostsScreen> {@override
void initState() {
  // TODO: implement initState
  context.read<ProfileLikedPostsBloc>().add(ProfileLikedPostsLoad());
  super.initState();
}
@override
Widget build(BuildContext context) {
  return BlocBuilder<ProfileLikedPostsBloc, ProfileLikedPostsState>(
    builder: (context, state) {
      if (state is ProfileLikedPostsInitial || state is ProfileLikedPostsLoading) {
        return const Scaffold(
            body: Center(child: CircularProgressIndicator()));
      } else if (state is ProfileLikedPostsSuccess) {
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
                            context.read<ProfileLikedPostsBloc>().add(ProfileLikedPostsLoad());
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

