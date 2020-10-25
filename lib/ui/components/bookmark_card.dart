import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/models/user.dart';
import 'package:arxiv_app/ui/views/home/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BookmarkCard extends StatefulWidget {
  BookmarkCard({this.paper, this.user});

  Paper paper;
  User user;

  @override
  _BookmarkCardState createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  bool _permissionReady;
  bool _isDownloaded;
  String _localPath;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    _permissionReady = false;
    _prepare();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    // ignore: omit_local_variable_types
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  Future<void> _prepare() async {
    // final tasks = await FlutterDownloader.loadTasks();
    _permissionReady = await _checkPermission();
    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'ArxivApp';
    final savedDir = Directory(_localPath);
    var hasExisted = await savedDir.exists();
    if (!hasExisted) {
      await savedDir.create();
    }
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
  }

  Future<String> _findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
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
      throw 'Could not launch $url';
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

  Future<void> download(String url) async {
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: _localPath,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Row(
      children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          IconButton(
              color: Colors.blueAccent,
              iconSize: ScreenUtil().setHeight(40),
              icon: Icon(Icons.open_in_browser),
              onPressed: () {
                _launchInBrowser(widget.paper.htmlUrl);
              })
        ]),
        Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.paper.title,
                        style: Theme.of(context).textTheme.headline2),
                    Text(
                        DateFormat('dd/MM/yyyy')
                            .format(widget.paper.datetimePaperPublished),
                        style: Theme.of(context).textTheme.headline2)
                  ]),
              Divider(
                thickness: ScreenUtil().setWidth(3),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(widget.paper.authors,
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
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.user.bookmarks.remove(Bookmark(
                              id: widget.paper.id,
                              datetimeCreated: DateTime.now(),
                              datetimeModified: DateTime.now(),
                              title: widget.paper.title,
                              authors: widget.paper.authors,
                              summary: widget.paper.summary,
                              comment: widget.paper.comment,
                              subjectClassification:
                                  widget.paper.subjectClassification,
                              category: widget.paper.category,
                              arxivId: widget.paper.arxivId,
                              htmlUrl: widget.paper.htmlUrl,
                              pdfUrl: widget.paper.pdfUrl,
                              datetimePaperPublished:
                                  widget.paper.datetimePaperPublished,
                              datetimePaperUpdated:
                                  widget.paper.datetimePaperUpdated,
                              mediaUrl: null));
                        });
                        Future.delayed(Duration(milliseconds: 500), () {
                          Navigator.of(context).pop();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomeView(index: 1)),
                              (Route<dynamic> route) => false);
                        });
                      }),
                  IconButton(
                      color: Colors.blue,
                      iconSize: ScreenUtil().setHeight(20),
                      icon: Icon(_isDownloaded
                          ? Icons.check_circle_outline
                          : Icons.file_download),
                      onPressed: () async {
                        if (_permissionReady) {
                          await download(widget.paper.pdfUrl);
                          setState(() {
                            _isDownloaded = true;
                            widget.user.downloads.add(Bookmark(
                                id: widget.paper.id,
                                datetimeCreated: DateTime.now(),
                                datetimeModified: DateTime.now(),
                                title: widget.paper.title,
                                authors: widget.paper.authors,
                                summary: widget.paper.summary,
                                comment: widget.paper.comment,
                                subjectClassification:
                                    widget.paper.subjectClassification,
                                category: widget.paper.category,
                                arxivId: widget.paper.arxivId,
                                htmlUrl: widget.paper.htmlUrl,
                                pdfUrl: widget.paper.pdfUrl,
                                datetimePaperPublished:
                                    widget.paper.datetimePaperPublished,
                                datetimePaperUpdated:
                                    widget.paper.datetimePaperUpdated,
                                mediaUrl: _localPath +
                                    Platform.pathSeparator +
                                    widget.paper.pdfUrl.split('pdf/')[1]));
                          });
                        } else {
                          _buildNoPermissionWarning();
                        }
                      })
                ]))
      ],
    )));
  }
}
