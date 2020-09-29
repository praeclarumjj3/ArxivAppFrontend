import 'package:arxiv_app/viewmodels/bookmarks/bookmark_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';

class BookMarkView extends StatefulWidget {
  static const String id = 'bookmark_view';

  @override
  _BookMarkState createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMarkView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BookMarkViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'BookMark View',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
