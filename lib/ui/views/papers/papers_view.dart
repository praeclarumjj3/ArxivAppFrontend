import 'package:arxiv_app/viewmodels/papers/paper_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';

class PaperView extends StatefulWidget {
  static const String id = 'paper_view';

  @override
  _PaperViewState createState() => _PaperViewState();
}

class _PaperViewState extends State<PaperView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PaperViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'Paper View',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
