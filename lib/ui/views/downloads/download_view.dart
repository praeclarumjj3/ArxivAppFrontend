import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/ui/components/download_card.dart';
import 'package:arxiv_app/ui/views/home/home_view.dart';
import 'package:arxiv_app/viewmodels/downloads/download_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';

class DownloadView extends StatefulWidget {
  static const String id = 'download_view';

  @override
  _DownloadViewState createState() => _DownloadViewState();
}

class _DownloadViewState extends State<DownloadView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Paper>> bookmarks;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('ArxivApp',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.white, fontWeight: FontWeight.w400)),
      leading: IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeView(
                          index: 3,
                          search: 'DEAP',
                        )),
                (Route<dynamic> route) => false);
          }),
      centerTitle: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DownloadViewModel>(
        onModelReady: (model) {
          model.getDownloads();
        },
        builder: (context, model, child) => Scaffold(
            appBar: buildAppBar(context),
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
                          'No Downloads!',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: model.downloads.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return DownloadCard(
                                download: model.downloads[index], model: model);
                          }),
            )));
  }
}
