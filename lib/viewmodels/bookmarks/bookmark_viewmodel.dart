import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/models/bookmark.dart';
import 'package:arxiv_app/services/navigation_service.dart';
import 'package:arxiv_app/services/paper_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';
import '../base_viewmodel.dart';

class BookmarkViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PaperService _paperService = locator<PaperService>();

  void navigate(String id) {
    _navigationService.pushNamedAndRemoveUntil(id);
  }

  List<Bookmark> _bookmarks = [];

  Future getBookmarks() async {
    setState(ViewState.Busy);
    dynamic result = await _paperService.getBookmarks();
    if (result == false) {
      setBookmarks([
        Bookmark(
            id: 1,
            title: 'Test',
            authors: 'JJ',
            summary: 'kk',
            comment: 'kkskjsjs',
            subjectClassification: 'hyuk,a',
            category: 'hyuk,a',
            arxivId: 'hyuk,a',
            htmlUrl: 'hyuk,a',
            pdfUrl: 'hyuk,a',
            datetimeCreated: DateTime.now(),
            datetimeModified: DateTime.now(),
            datetimePaperPublished: DateTime.now(),
            datetimePaperUpdated: DateTime.now(),
            mediaUrl: null)
      ]);
      setState(ViewState.Error);
      setErrorMessage('Bookmarks not found!');
    } else {
      setBookmarks(result);
      setState(ViewState.Idle);
    }
  }

  void setBookmarks(List<Bookmark> bookmarks) {
    _bookmarks = bookmarks;
    notifyListeners();
  }

  void modifyBookmark(String action, String arxivId) {
    dynamic result = _paperService.modifyBookmark(action, arxivId);

    if (result == false) {
      Fluttertoast.showToast(
          msg: 'Could not Bookmark!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true));
    } else {
      getBookmarks();
    }
  }

  void modifyDownload(String action, String arxivId, String downloadURL) {
    dynamic result = _paperService.modifyDownload(action, arxivId, downloadURL);

    if (result == false) {
      Fluttertoast.showToast(
          msg: 'Could not Delete!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true));
    } else {
      getBookmarks();
    }
  }

  List<Bookmark> get bookmarks => _bookmarks;
}
