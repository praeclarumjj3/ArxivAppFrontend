import 'package:arxiv_app/viewmodels/downloads/download_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';

class DownloadView extends StatefulWidget {
  static const String id = 'download_view';

  @override
  _DownloadViewState createState() => _DownloadViewState();
}

class _DownloadViewState extends State<DownloadView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<DownloadViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'Download View',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
