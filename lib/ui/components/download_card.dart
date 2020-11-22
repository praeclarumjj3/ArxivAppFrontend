import 'dart:io';
import 'package:arxiv_app/models/bookmark.dart';
import 'package:arxiv_app/ui/views/home/home_view.dart';
import 'package:arxiv_app/viewmodels/downloads/download_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DownloadCard extends StatefulWidget {
  DownloadCard({this.download, this.model});

  Bookmark download;
  DownloadViewModel model;

  @override
  _DownloadCardState createState() => _DownloadCardState();
}

class _DownloadCardState extends State<DownloadCard> {
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

  Future<void> deleteFile(String path) async {
    try {
      var file = File(path);

      if (await file.exists()) {
        // file exits, it is safe to call delete on it
        await file.delete();
      }
    } catch (e) {
      // error in getting access to the file
      print(e);
    }
  }

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
                      color: Colors.blue,
                      iconSize: ScreenUtil().setHeight(40),
                      icon: Icon(Icons.open_in_browser),
                      onPressed: () {
                        _launchInBrowser(widget.download.pdfUrl);
                      })
                ]),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  Text(widget.download.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w300)),
                  Divider(
                    thickness: ScreenUtil().setWidth(3),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                          widget.download.authors.replaceAll('&#&', ', '),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1)),
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
                            widget.model.modifyDownload(
                                'remove',
                                widget.download.arxivId,
                                widget.download.mediaUrl);
                            deleteFile(widget.download.mediaUrl);
                            Future.delayed(Duration(milliseconds: 1000), () {
                              Navigator.of(context).pop();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeView(index: 3, search: 'DEAP')),
                                  (Route<dynamic> route) => false);
                            });
                          }),
                    ]))
          ],
        ))));
  }
}
