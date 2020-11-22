import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/ui/components/paper_card.dart';
import 'package:arxiv_app/ui/views/home/home_view.dart';
import 'package:arxiv_app/viewmodels/papers/paper_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../../base_view.dart';

// ignore: must_be_immutable
class PaperView extends StatefulWidget {
  static const String id = 'paper_view';

  PaperView({this.search});

  String search;

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
    Navigator.of(context).pop();
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomeView(index: 0, search: value)),
          (Route<dynamic> route) => false);
    });
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
          model.getPapers(widget.search);
        },
        builder: (context, model, child) => Scaffold(
            appBar: searchBar.build(context),
            key: _scaffoldKey,
            body: Center(
              child: model.state == ViewState.Busy
                  ? Center(
                      child: CircularProgressIndicator(
                        value: null,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    )
                  : model.state == ViewState.Error
                      ? Text(
                          'Search did not work!',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: model.papers.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return PaperCard(
                                paper: model.papers[index], model: model);
                          }),
            )));
  }
}
