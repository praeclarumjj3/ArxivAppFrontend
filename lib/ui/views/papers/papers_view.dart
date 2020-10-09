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
  // Future<List<Paper>> papers;

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

  // Widget paperList() {
  //   return Expanded(
  //       child: FutureBuilder<List>(
  //         future: papers,
  //         builder: (context, snapshot) {
  //           print(snapshot.hasData);
  //           return snapshot.hasData
  //               ? snapshot.data.isEmpty
  //               ? Center(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Text(
  //                   'Add Tasks to better track your time!',
  //                   style: GoogleFonts.poppins(
  //                       textStyle: TextStyle(
  //                           fontSize: ScreenUtil()
  //                               .setSp(40, allowFontScalingSelf: true),
  //                           fontWeight: FontWeight.w600,
  //                           color: Colors.grey)),
  //                 ),
  //               ],
  //             ),
  //           )
  //               : ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: snapshot.data.length,
  //             itemBuilder: (context, position) {
  //               return PaperCard(
  //                 title: 'JJ Rocks',
  //               );
  //             },
  //           )
  //               : Center(
  //             child: CircularProgressIndicator(
  //                 value: null,
  //                 valueColor:
  //                 AlwaysStoppedAnimation<Color>(Colors.blue)),
  //           );
  //         },
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return BaseView<PaperViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: searchBar.build(context),
        key: _scaffoldKey,
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
