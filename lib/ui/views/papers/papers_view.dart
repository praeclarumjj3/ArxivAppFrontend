import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/models/user.dart';
import 'package:arxiv_app/ui/components/paper_card.dart';
import 'package:arxiv_app/viewmodels/papers/paper_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../../base_view.dart';

class PaperView extends StatefulWidget {
  static const String id = 'paper_view';

  @override
  _PaperViewState createState() => _PaperViewState();
}

class _PaperViewState extends State<PaperView> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Paper>> papers;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text('ArxivApp',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400)),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmittedSearch(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('You wrote $value!'))));
  }

  _PaperViewState() {
    searchBar = SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmittedSearch,
        onCleared: () {
          print('cleared');
        },
        onClosed: () {
          print('closed');
        });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PaperViewModel>(
        onModelReady: (model) {
          model.setPapers();
        },
        builder: (context, model, child) => Scaffold(
            appBar: searchBar.build(context),
            key: _scaffoldKey,
            body: Center(
              child: model.papers.isEmpty
                  ? Text(
                      'Search something',
                      style: Theme.of(context).textTheme.headline2,
                    )
                  : ListView.builder(
                      itemCount: model.papers.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return PaperCard(
                          paper: model.papers[index],
                          user: User(
                              id: 1,
                              emailAddress: 'jjjj',
                              downloads: [],
                              bookmarks: [],
                              profilePicture: null,
                              fullName: 'jshshhs',
                              username: 'jsjsjs'),
                        );
                      }),
            )));
  }
}
