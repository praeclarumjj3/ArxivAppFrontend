import 'package:arxiv_app/models/paper.dart';

import '../base_viewmodel.dart';

class DownloadViewModel extends BaseViewModel {
  List<Paper> _downloads;

  // Placeholder example
  void setDownloads() {
    _downloads = [
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
    ];
    notifyListeners();
  }

  List<Paper> get downloads => _downloads;
}
