import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/viewmodels/blog/blog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../../base_view.dart';

class BlogView extends StatefulWidget {
  static const String id = 'blog_view';

  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Paper>> papers;

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
    return BaseView<BlogViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: searchBar.build(context),
            key: _scaffoldKey,
            body: Center(
                child: Text(
              'Forum View',
              style: Theme.of(context).textTheme.headline2,
            ))));
  }
}
