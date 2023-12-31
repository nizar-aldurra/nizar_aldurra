import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nizar_aldurra/BloC/add_comment/add_comment_bloc.dart';
import 'package:nizar_aldurra/BloC/comments/comments_bloc.dart';
import 'package:nizar_aldurra/models/comment.dart';
import 'package:nizar_aldurra/screens/user_screen.dart';

class CommentsScreen extends StatelessWidget {
  static const routeName = 'comments_screen';

  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    String postId = arguments['post_id'];
    int commentsNum = arguments['commentsNum'];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CommentsBloc(),
        ),
        BlocProvider(
          create: (context) => AddCommentBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: CommentsWidget(postId,commentsNum),
      ),
    );
  }
}

class CommentsWidget extends StatefulWidget {
  CommentsWidget(
    this.postId, this.commentsNum, {
    super.key,
  });

  String postId;
  int commentsNum;

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState(postId);
}

class _CommentsWidgetState extends State<CommentsWidget> {
  _CommentsWidgetState(String postId);

  final AddCommentBloc _addCommentBloc = AddCommentBloc();

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context,widget.commentsNum);
        return false;
      },
      child: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          return BlocBuilder<AddCommentBloc, AddCommentState>(
            bloc: _addCommentBloc,
            builder: (context, state1) {
              if (state is CommentsInitial || state is CommentsLoading) {
                context.read<CommentsBloc>().add(CommentsLoad(widget.postId));
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              } else if (state is CommentsSuccess) {
                List<Comment> comments = state.comment;
                if (comments.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: Center(child: Text('no comments'))),
                        Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.83,
                                child: TextField(
                                  maxLines: 3,
                                  controller: textEditingController,
                                  decoration: const InputDecoration(
                                    hintText: 'write a comment ....',
                                  ),
                                  onChanged: (value) {
                                    _addCommentBloc
                                        .add(BodyCommentChanged(value));
                                  },
                                )),
                            IconButton(
                                onPressed: () {
                                  _addCommentBloc.add(
                                      AddCommentButtonPressed(widget.postId));
                                  context
                                      .read<CommentsBloc>()
                                      .add(CommentsLoad(widget.postId));
                                  textEditingController.clear();
                                  widget.commentsNum=widget.commentsNum+1;
                                },
                                icon: const Icon(Icons.send))
                          ],
                        ),
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
                        Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.83,
                                child: TextField(
                                  maxLines: 3,
                                  controller: textEditingController,
                                  decoration: const InputDecoration(
                                    hintText: 'write a comment ....',
                                  ),
                                  onChanged: (value) {
                                    _addCommentBloc
                                        .add(BodyCommentChanged(value));
                                  },
                                )),
                            IconButton(
                                onPressed: () {
                                  _addCommentBloc.add(
                                      AddCommentButtonPressed(widget.postId));
                                  context
                                      .read<CommentsBloc>()
                                      .add(CommentsLoad(widget.postId));
                                  widget.commentsNum=widget.commentsNum+1;
                                  textEditingController.clear();
                                },
                                icon: const Icon(Icons.send))
                          ],
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
        },
      ),
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
                style: const TextStyle(
                    fontSize: 30, color: Colors.black),
              ),
            ),
            Text(
              comments[index].publishedAt?.timeZoneName == null
                  ? 'null'
                  : DateFormat('dd/MM/yyyy  HH:mm:a')
                      .format(comments[index].publishedAt!),
              style: const TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(comments[index].body),
            ),
          ],
        ),
      ),
    );
  }
}
