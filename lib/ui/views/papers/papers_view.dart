import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/ui/components/paper_card.dart';
import 'package:arxiv_app/viewmodels/papers/paper_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery;

  AppBar buildAppBar(BuildContext context, PaperViewModel model) {
    return AppBar(
      leading: _isSearching ? const BackButton() : null,
      title: _isSearching ? _buildSearchField(model) : _buildTitle(context),
      actions: _buildActions(model),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text('ArxivApp',
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Colors.white, fontWeight: FontWeight.w400));
  }

  Widget _buildSearchField(PaperViewModel model) {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
          fontSize: ScreenUtil().setSp(14, allowFontScalingSelf: true)),
      onSubmitted: (query) => updateSearchQuery(model, query),
    );
  }

  List<Widget> _buildActions(PaperViewModel model) {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(PaperViewModel model, String newQuery) {
    model.getPapers(newQuery);
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PaperViewModel>(
        onModelReady: (model) {
          model.getPapers(widget.search);
        },
        builder: (context, model, child) => Scaffold(
            appBar: buildAppBar(context, model),
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
