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
    var uri = URL + 'users/';
    try {
      var response = await dio.post(uri, data: {
        'username': _localStorageService.userEmail.split('@')[0],
        'full_name': _localStorageService.username,
        'profile_picture': _localStorageService.userPic,
        'email_address': _localStorageService.userEmail
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        _localStorageService.authToken = response.data['id'];
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
