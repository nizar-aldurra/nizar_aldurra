import 'dart:convert';

import 'package:http_parser/http_parser.dart';
import 'package:nizar_aldurra/models/post.dart';
import 'package:nizar_aldurra/repositories/base_repository.dart';

import 'package:http/http.dart' as http;

import '../app/app_data.dart';

class PostsRepository extends BaseRepository {
  PostsRepository() : super(controller: 'post');

  storePost(Post post) async{
    Uri uri= Uri.parse('${AppData.baseURL}/$controller/create');
    var request = http.MultipartRequest('POST',uri);
    request.headers['Authorization'] ='Bearer ${AppData.token}';

    request.fields['title'] = post.title;
    request.fields['body'] = post.body;

    for (var i=0;i< post.images!.length;i++){
      var image = post.images![i];
      var multiPartFile = await http.MultipartFile.fromPath('images[$i]', image.path,contentType: MediaType('image','jpeg'));
      request.files.add(multiPartFile);
    }
    print(request.files);

    var response = await request.send();
    if(response.statusCode ==  200){
      print('post uploaded successfully');
      return true;
    }else {
      print('Error uploading post , Status error : ${response.statusCode}');
      return false;
    }
  }
  getPostComments(String postId) async {
    var response = await http.get(
        Uri.parse('${AppData.baseURL}/$controller/$postId/comments'),
        headers: header());
    var result;
    result = jsonDecode(response.body);
    return result;
  }

  changeLikingStatus(String postId) async {
    var response = await http.get(
        Uri.parse(
            '${AppData.baseURL}/$controller/$postId/change_liking_status'),
        headers: header());
    return jsonDecode(response.body);
  }

}
