import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/models/bookmark.dart';
import 'package:arxiv_app/services/navigation_service.dart';
import 'package:arxiv_app/services/paper_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';
import '../base_viewmodel.dart';

class DownloadViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PaperService _paperService = locator<PaperService>();

  void navigate(String id) {
    _navigationService.pushNamedAndRemoveUntil(id);
  }

  List<Bookmark> _downloads = [];

  Future getDownloads() async {
    setState(ViewState.Busy);
    dynamic result = await _paperService.getDownloads();
    if (result == false) {
      setState(ViewState.Error);
      setErrorMessage('Downloads not found!');
    } else {
      setDownloads(result);
      setState(ViewState.Idle);
    }
  }

  void setDownloads(List<Bookmark> downloads) {
    _downloads = downloads;
    notifyListeners();
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
      getDownloads();
    }
  }

  List<Bookmark> get downloads => _downloads;
}
