import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nizar_aldurra/BloC/comments/comments_bloc.dart';
import 'package:nizar_aldurra/models/comment.dart';

class CommentsScreen extends StatelessWidget {
  static const routeName = 'comments_screen';

  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    String postId = arguments['post_id'];
    return BlocProvider(
      create: (context) => CommentsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: CommentsWidget(postId),
      ),
    );
  }
}

class CommentsWidget extends StatefulWidget {
  CommentsWidget(this.postId, {
    super.key,
  });
  String postId;
  @override
  State<CommentsWidget> createState() => _CommentsWidgetState(postId);
}

class _CommentsWidgetState extends State<CommentsWidget> {
  _CommentsWidgetState(String postId);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state is CommentsInitial || state is CommentsLoading) {
          context.read<CommentsBloc>().add(CommentsLoad(widget.postId));
        return const Scaffold(
            body: Center(child: CircularProgressIndicator()));
      } else if (state is CommentsSuccess) {
        List<Comment> comments = state.comment;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (BuildContext context, int index) {
                return commentCard(index, comments);
              }),
        );
      }else if(state is CommentsFailure){
          return const Center(child: Text('no comments'));
        }
      return const Center(
        child: Text('Problem in Server'),
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
            const Text(
              'Comment writer',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              comments[index].publishedAt?.timeZoneName == null
                  ? 'null'
                  : DateFormat('dd/MM/yyyy  hh:mm')
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