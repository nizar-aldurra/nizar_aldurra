import 'dart:convert';

import 'package:nizar_aldurra/repositories/base_repository.dart';

import 'package:http/http.dart' as http;

import '../app/app_data.dart';

class UserRepository extends BaseRepository {
  UserRepository() : super(controller: 'user');

  getUserPosts(String userId) async {
    var response = await http.get(
        Uri.parse('${AppData.baseURL}/$controller/posts/$userId'),
        headers: header());
    var result;
    result = jsonDecode(response.body);
    return result;
  }
}