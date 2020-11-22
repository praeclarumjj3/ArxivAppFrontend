import 'dart:ui';
import 'package:arxiv_app/viewmodels/papers/paper_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:arxiv_app/models/paper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PaperCard extends StatefulWidget {
  PaperCard({this.paper, this.model});

  Paper paper;
  PaperViewModel model;

  @override
  _PaperCardState createState() => _PaperCardState();
}

class _PaperCardState extends State<PaperCard> {
  bool _isBookmarked = false;
  bool _isDownloaded = false;
  bool _permissionReady;

  @override
  void initState() {
    super.initState();
    _permissionReady = false;
    _prepare();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _prepare() async {
    // final tasks = await FlutterDownloader.loadTasks();
    _permissionReady = await _checkPermission();
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<bool> _checkPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      await Fluttertoast.showToast(
          msg: "Can't open the url!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true));
    }
  }

  Widget _buildNoPermissionWarning() => Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Please grant accessing storage permission to continue -_-',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              FlatButton(
                  onPressed: () {
                    _checkPermission().then((hasGranted) {
                      setState(() {
                        _permissionReady = hasGranted;
                      });
                    });
                  },
                  child: Text(
                    'Retry',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ))
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10),
            ScreenUtil().setWidth(10), ScreenUtil().setWidth(10), 0),
        child: Container(
            child: Card(
                child: Row(
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      color: Colors.blueAccent,
                      iconSize: ScreenUtil().setHeight(40),
                      icon: Icon(_isDownloaded
                          ? Icons.check_circle_outline
                          : Icons.file_download),
                      onPressed: () async {
                        if (_isDownloaded) {
                        } else {
                          if (_permissionReady) {
                            await _launchInBrowser(widget.paper.htmlUrl);
                            setState(() {
                              _isDownloaded = true;
                              widget.model.modifyDownload(
                                  'add',
                                  widget.paper.arxivId,
                                  'Internal Storage/Download/' +
                                      widget.paper.htmlUrl.split('pdf/')[1] +
                                      '.pdf');
                            });
                          } else {
                            _buildNoPermissionWarning();
                          }
                        }
                      })
                ]),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  Text(widget.paper.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w300)),
                  Divider(
                    thickness: ScreenUtil().setWidth(3),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(widget.paper.authors.replaceAll('&#&', ', '),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1))
                ])),
            Align(
                alignment: Alignment.centerRight,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          color: Colors.red,
                          iconSize: ScreenUtil().setHeight(20),
                          icon: Icon(
                              _isBookmarked ? Icons.star : Icons.star_border),
                          onPressed: () {
                            if (_isBookmarked) {
                              setState(() {
                                _isBookmarked = false;
                                widget.model.modifyBookmark(
                                    'remove', widget.paper.arxivId);
                              });
                            } else {
                              setState(() {
                                _isBookmarked = true;
                                widget.model.modifyBookmark(
                                    'add', widget.paper.arxivId);
                              });
                            }
                          }),
                      IconButton(
                          color: Colors.blue,
                          iconSize: ScreenUtil().setHeight(20),
                          icon: Icon(Icons.open_in_browser),
                          onPressed: () {
                            _launchInBrowser(widget.paper.pdfUrl);
                          })
                    ]))
          ],
        ))));
  }
}
