import 'package:arxiv_app/viewmodels/forum/forum_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';

class ForumView extends StatefulWidget {
  static const String id = 'forum_view';

  @override
  _ForumViewState createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ForumViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'Forum View',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
