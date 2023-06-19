import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nizar_aldurra/app/app_data.dart';

class BaseRepository {
  final String controller;

  BaseRepository({required this.controller});

  header() => {
        'Authorization': 'Bearer ${AppData.token}',
        'content-type': 'application/json',
        'accept': 'application/json',
      };

  getAll() async {
    var response = await http.get(
        Uri.parse('${AppData.baseURL}/$controller/all'),
        headers: header());
    var result;
    // try {
    result = jsonDecode(response.body);
    // } catch (error) {
    //   print(error);
    // }
    return result;
  }

  Future<List<dynamic>> get(String id) async {
    var response = await http.get(
        Uri.parse('${AppData.baseURL}/$controller/$id'),
        headers: header());
    var result = [];
    try {} catch (error) {}
    return result;
  }

  storeData(dynamic data) async {
    var response = await http.post(
      Uri.parse('${AppData.baseURL}/$controller/create'),
      headers: header(),
      body: jsonEncode(data.toMap()),
    );
    var result;
    try {
      result = jsonDecode(response.body);
      print(response.statusCode);
    } catch (error) {
      print(error);
    }
    return result;
  }

  updateData(dynamic data) async {
    var response = await http.post(
      Uri.parse('${AppData.baseURL}/$controller/create'),
      headers: header(),
      body: data.toMap(),
    );
    var result = [];
    try {
      result = json.decode(response.body);
      print(response.statusCode);
    } catch (error) {
      print(error);
    }
    return result;
  }

  deleteData(String id) async {
    var response = await http.delete(
      Uri.parse('${AppData.baseURL}/$controller/$id'),
      headers: header(),
    );
  }
}
