import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/services/navigation_service.dart';

import '../../locator.dart';
import '../base_viewmodel.dart';

class DownloadViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigate(String id) {
    _navigationService.pushNamedAndRemoveUntil(id);
  }

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
