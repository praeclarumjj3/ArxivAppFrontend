import 'package:arxiv_app/ui/utils/destination.dart';
import 'package:arxiv_app/ui/views/bookmarks/bookmark_view.dart';
import 'package:arxiv_app/ui/views/downloads/download_view.dart';
import 'package:arxiv_app/ui/views/forum/forum_view.dart';
import 'package:arxiv_app/ui/views/papers/papers_view.dart';
import 'package:arxiv_app/viewmodels/home/home_viewmodel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base_view.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  static const String id = 'home_view';

  HomeView({this.index});

  int index;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin<HomeView> {
  int _currentIndex = 0;
  final Connectivity _connectivity = Connectivity();
  String _connectionStatus;
  bool isLoading;

  void checkConnection() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result.toString();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) {
          _currentIndex = widget.index;
          checkConnection();
          isLoading = false;
        },
        builder: (context, model, child) => Scaffold(
              body: _connectionStatus == 'ConnectivityResult.none'
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setWidth(10)),
                              child: Text(
                                'Checking for internet',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                          Center(
                            child: CircularProgressIndicator(
                                value: null,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red)),
                          )
                        ],
                      ),
                    )
                  : SafeArea(
                      top: false,
                      child: IndexedStack(
                          index: _currentIndex,
                          children: <Widget>[
                            PaperView(),
                            BookMarkView(),
                            DownloadView(),
                            ForumView()
                          ]),
                    ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                    print(_currentIndex);
                  });
                },
                items: allDestinations.map((Destination destination) {
                  return BottomNavigationBarItem(
                      icon: Icon(
                        destination.icon,
                        color: Colors.red,
                      ),
                      title: Text(
                        destination.title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ));
                }).toList(),
              ),
            ));
  }
}
