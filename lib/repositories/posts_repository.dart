import 'dart:convert';

import 'package:nizar_aldurra/repositories/base_repository.dart';

import 'package:http/http.dart' as http;

import '../app/app_data.dart';

class PostsRepository extends BaseRepository{
  PostsRepository(): super(controller: 'post');
  getPostComments(String postId)async{
    var response = await http.get(
        Uri.parse('${AppData.baseURL}/$controller/$postId/comments'),
        headers: header());
    var result;
    result = jsonDecode(response.body);
    return result;
  }
}