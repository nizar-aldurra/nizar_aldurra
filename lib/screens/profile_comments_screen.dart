import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nizar_aldurra/BloC/profile_comments/profile_comments_bloc.dart';
import 'package:nizar_aldurra/screens/user_screen.dart';

import '../models/comment.dart';

class ProfileCommentsScreen extends StatefulWidget {
  static var routeName='profile_comments_screen';

  const ProfileCommentsScreen({super.key});

  @override
  State<ProfileCommentsScreen> createState() => _ProfileCommentsScreenState();
}

class _ProfileCommentsScreenState extends State<ProfileCommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCommentsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: CommentsWidget(),
      ),
    );
  }
}

class CommentsWidget extends StatefulWidget {
  CommentsWidget({
    super.key,
  });

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  _CommentsWidgetState();

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return BlocBuilder<ProfileCommentsBloc, ProfileCommentsState>(
      builder: (context, state) {
        if (state is ProfileCommentsInitial ||
            state is ProfileCommentsLoading) {
          context.read<ProfileCommentsBloc>().add(ProfileCommentsLoad());
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is ProfileCommentsSuccess) {
          List<Comment> comments = state.comment;
          if (comments.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Center(child: Text('no comments'))),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return commentCard(index, comments);
                        }),
                  ),
                ],
              ),
            );
          }
        }
        return const Center(
          child: Text('Problem in Connection'),
        );
      },
    );
  }

  Widget commentCard(int index, List<Comment> comments) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          UserScreen(userId: comments[index].userId!)),
                );
              },
              child: Text(
                comments[index].userName!,
                style: const TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            Text(
              comments[index].publishedAt?.timeZoneName == null
                  ? 'null'
                  : DateFormat('dd/MM/yyyy  HH:mm:a')
                      .format(comments[index].publishedAt!),
              style: const TextStyle(fontSize: 18),
            ),
            Text(comments[index].body),
          ],
        ),
      ),
    );
  }
}
