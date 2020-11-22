import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static const String isLoggedInKey = 'is_logged_in_key';
  static const String usernameKey = 'username_key';
  static const String authTokenKey = 'auth_token_key';
  static const String userEmailKey = 'user_email_key';
  static const String userPicKey = 'user_pic_key';

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  bool get isLoggedIn => _getFromDisk(isLoggedInKey) ?? false;

  String get username => _getFromDisk(usernameKey) ?? 'Username';

  int get authToken => _getFromDisk(authTokenKey) ?? -1;

  String get userEmail => _getFromDisk(userEmailKey) ?? 'EmailId';

  String get userPic => _getFromDisk(userPicKey) ?? 'Pic';

  set isLoggedIn(bool isLoggedIn) {
    _saveToDisk(isLoggedInKey, isLoggedIn);
  }

  set username(String username) {
    _saveToDisk(usernameKey, username);
  }

  set authToken(int authToken) {
    _saveToDisk(authTokenKey, authToken);
  }

  set userEmail(String mail) {
    _saveToDisk(userEmailKey, mail);
  }

  set userPic(String url) {
    _saveToDisk(userPicKey, url);
  }
}
