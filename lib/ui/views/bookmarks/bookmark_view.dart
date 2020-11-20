import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/ui/components/bookmark_card.dart';
import 'package:arxiv_app/viewmodels/bookmarks/bookmark_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';

class BookMarkView extends StatefulWidget {
  static const String id = 'bookmark_view';

  @override
  _BookMarkState createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMarkView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Paper>> bookmarks;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text('ArxivApp',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400)));
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BookmarkViewModel>(
        onModelReady: (model) {
          model.getBookmarks();
        },
        builder: (context, model, child) => Scaffold(
            appBar: buildAppBar(context),
            key: _scaffoldKey,
            body: Center(
              child: model.bookmarks.isEmpty
                  ? Text(
                      'No Bookmarks!',
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    )
                  : ListView.builder(
                      itemCount: model.bookmarks.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return BookmarkCard(
                            bookmark: model.bookmarks[index], model: model);
                      }),
            )));
  }
}
