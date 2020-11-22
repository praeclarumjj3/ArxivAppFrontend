import 'package:arxiv_app/locator.dart';
import 'package:arxiv_app/services/local_storage_service.dart';
import 'package:dio/dio.dart';
import '../globals.dart';

class AuthService {
  var dio = Dio(BaseOptions(
    connectTimeout: 60000,
    receiveTimeout: 60000,
  ));

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  Future getAuthToken(String name, email, profile_pic) async {
    var uri = URL + 'auth/login/';
    try {
      var response = await dio.post(uri, data: {
        'display_name': _localStorageService.username,
        'email': _localStorageService.userEmail,
        'profile_url': _localStorageService.userPic,
      });
      if (response.statusCode == 200) {
        _localStorageService.authToken = response.data;
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
