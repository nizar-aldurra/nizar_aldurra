import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nizar_aldurra/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/app_data.dart';

class AuthRepository {
  final String controller = 'auth';

  header() => {
        'content-type': 'application/json',
        'accept': 'application/json',
      };

  headerWithAuh() => {
        'Authorization': 'Bearer ${AppData.token}',
        'content-type': 'application/json',
        'accept': 'application/json',
      };

  Future<dynamic> register(String userName, String email, String password,
      String confirmPassword) async {
    var response = await http.post(
      Uri.parse('${AppData.baseURL}/$controller/register'),
      headers: header(),
      body: jsonEncode({
        'name': userName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword
      }),
    );
    if (response.statusCode == 200) {
      try{
        AppData.token = jsonDecode(response.body)['token'];
        User user = User.fromMap(jsonDecode(response.body)['user']);
        AppData.userId = user.id!;
        user.token = AppData.token;
        AppData.isAdmin = user.isAdmin!;
        print(user.email);
        return user;
      }catch(error){
        return "The email or password is incorrect";
      }
    } else {
      return 'The email or password is incorrect';
    }
  }

  Future<dynamic?> login(String email, String password) async {
    var response = await http.post(
      Uri.parse('${AppData.baseURL}/$controller/login'),
      headers: header(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      User user;
      try{
        AppData.token = jsonDecode(response.body)['token'];
        user = User.fromMap(jsonDecode(response.body)['user']);
        AppData.userId = user.id!;
        user.token = AppData.token;
        AppData.isAdmin = user.isAdmin!;
        print(user.email);
      }catch(error){
        return 'The email or password is incorrect';
      }
      return user;
    } else {
      return 'The email or password is incorrect';
    }
  }

  void logout() async {
    var response = await http.get(
        Uri.parse('${AppData.baseURL}/$controller/logout'),
        headers: headerWithAuh());
    AppData.token = '';
    SharedPreferences.getInstance()
        .then((value) => value.setString('user', '-1'));
  }
}
