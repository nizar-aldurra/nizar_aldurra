import 'dart:convert';

import 'package:nizar_aldurra/repositories/base_repository.dart';

import 'package:http/http.dart' as http;

import '../app/app_data.dart';
import '../models/user.dart';

class UserRepository extends BaseRepository {
  UserRepository() : super(controller: 'user');

  getUserPosts(String userId) async {
    var response = await http.get(
        Uri.parse('${AppData.baseURL}/$controller/posts/$userId'),
        headers: header());
    var result = jsonDecode(response.body);
    return result;
  }

  UpdateInfoScreen(String userName, String email) async {
    var response =
        await http.post(Uri.parse('${AppData.baseURL}/$controller/UpdateInfoScreen'),
            headers: header(),
            body: jsonEncode({
              'name': userName,
              'email': email,
            }));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  updatePassword(String currentPassword,String newPassword,) async {
    var response =
        await http.post(Uri.parse('${AppData.baseURL}/$controller/updatePassword'),
            headers: header(),
            body: jsonEncode({
              'current_password' : currentPassword,
              'new_password' : newPassword,
            }));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
