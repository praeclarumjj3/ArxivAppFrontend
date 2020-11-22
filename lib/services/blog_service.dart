import 'package:arxiv_app/locator.dart';
import 'package:arxiv_app/models/blog.dart';
import 'package:arxiv_app/services/local_storage_service.dart';
import 'package:dio/dio.dart';
import '../globals.dart';

class BlogService {
  var dio = Dio(BaseOptions(
    connectTimeout: 60000,
    receiveTimeout: 60000,
  ));

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  Future getBlogs() async {
    var uri = URL + 'blogs/';
    try {
      var response = await dio.get(uri);
      if (response.statusCode == 200) {
        final blogs = Blog.fromJson(response.data);
        return blogs;
      } else {
        return false;
      }
    } catch (e) {
      print('Caught Exception: $e');
      return false;
    }
  }

  Future createBlog(String title, String body) async {
    var uri = URL + 'blogs/';
    try {
      var response = await dio.post(
        uri,
        data: {
          'title': title,
          'body': body,
          'author': _localStorageService.authToken,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        print('Timeout Error!!');
        return false;
      } else if (e.type == DioErrorType.CANCEL) {
        print('Cancel Error!!');
        return false;
      } else if (e.type == DioErrorType.DEFAULT) {
        print('Default Error!!');
        return false;
      } else if (e.type == DioErrorType.RESPONSE) {
        print('Response Error!!');
        return false;
      }
    }
  }

  Future voteBlog(String id, String action) async {
    var uri = URL + 'blogs/$id/vote/?vote=$action'; // action = 'up' or 'down'
    try {
      var response = await dio.get(uri);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Caught Exception: $e');
      return false;
    }
  }
}
