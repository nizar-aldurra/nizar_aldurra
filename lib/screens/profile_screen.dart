import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BloC/profile/profile_bloc.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = 'profile_screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ProfileBloc>().add(ProfileLoad());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial || state is ProfileLoading) {
          return const Center(child: Scaffold(body: Center(child: CircularProgressIndicator())));
        } else if (state is ProfileSuccess) {
          User user = state.user;
          int postsNum = state.postsNum;
          int commentsNum = state.commentsNum;
          int likesNum = state.likesNum;

          return Scaffold(
            body: Column(
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
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ElevatedButton(onPressed: (){}, child: const Text('Posts')),
                        ElevatedButton(onPressed: (){}, child: const Text('comments')),
                        ElevatedButton(onPressed: (){}, child: const Text('Liked Posts')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text('Problem in Server'),
        );
      },
    );
  }
}
