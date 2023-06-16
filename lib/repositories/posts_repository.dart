import 'package:nizar_aldurra/repositories/base_repository.dart';

import '../models/post.dart';

class PostsRepository extends BaseRepository{
  PostsRepository(): super(controller: 'post');
}