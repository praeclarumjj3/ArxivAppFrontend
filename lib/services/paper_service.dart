import 'package:arxiv_app/locator.dart';
import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/models/bookmark.dart';
import 'package:arxiv_app/services/local_storage_service.dart';
import 'package:dio/dio.dart';
import '../globals.dart';

class PaperService {
  var dio = Dio(BaseOptions(
    connectTimeout: 60000,
    receiveTimeout: 60000,
  ));

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  Future getPapers(String keyword) async {
    var uri = URL + 'papers/search/?ti=$keyword';
    try {
      var response = await dio.get(uri);
      if (response.statusCode == 200) {
        final papers = Paper.fromJson(response.data.Results);
        return papers;
      } else {
        return false;
      }
    } catch (e) {
      print('Caught Exception: $e');
      return false;
    }
  }

  Future modifyBookmark(String action, String arxivId) async {
    var uri = URL + 'users/bookmark/';
    try {
      var response = await dio.post(
        uri,
        data: {
          'action': action, // 'add' or 'remove'
          'arxiv_id': arxivId, // arxiv_id of paper that needs to be bookmarked
          'auth_token': _localStorageService.authToken,
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

  Future getBookmarks() async {
    var uri = URL + 'users/bookmark/';
    try {
      var response = await dio.post(
        uri,
        data: {
          'auth_token': _localStorageService.authToken,
        },
      );
      if (response.statusCode == 200) {
        final bookmarks = Bookmark.fromJson(response.data);
        return bookmarks;
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

  Future modifyDownload(
      String action, String arxivId, String downloadURL) async {
    var uri = URL + 'users/download/';
    try {
      var response = await dio.post(
        uri,
        data: {
          'action': action,
          'arxiv_id': arxivId,
          'download_url': downloadURL,
          'auth_token': _localStorageService.authToken,
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

  Future getDownloads() async {
    var uri = URL + 'users/download/';
    try {
      var response = await dio.post(
        uri,
        data: {
          'auth_token': _localStorageService.authToken,
        },
      );
      if (response.statusCode == 200) {
        final downloads = Bookmark.fromJson(response.data);
        return downloads;
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
}
