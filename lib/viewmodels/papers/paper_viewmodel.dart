import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/services/navigation_service.dart';
import 'package:arxiv_app/services/paper_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../locator.dart';
import '../base_viewmodel.dart';

class PaperViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PaperService _paperService = locator<PaperService>();

  void navigate(String id) {
    _navigationService.pushNamedAndRemoveUntil(id);
  }

  List<Paper> _papers = [];

  Future getPapers(String keyword) async {
    setState(ViewState.Busy);
    dynamic result = await _paperService.getPapers(keyword);
    if (result == false) {
      setPapers([
        Paper(
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
            datetimePaperPublished: DateTime.now(),
            datetimePaperUpdated: DateTime.now())
      ]);
      setState(ViewState.Error);
      setErrorMessage('Papers not found!');
    } else {
      setPapers(result);
      setState(ViewState.Idle);
    }
  }

  void setPapers(List<Paper> papers) {
    _papers = papers;
    notifyListeners();
  }

  void modifyDownload(String action, String arxivId, String downloadURL) {
    dynamic result = _paperService.modifyDownload(action, arxivId, downloadURL);

    if (result == false) {
      Fluttertoast.showToast(
          msg: 'Could not Download!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true));
    }
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
    }
  }

  List<Paper> get papers => _papers;
}
