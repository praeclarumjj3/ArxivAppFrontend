import 'package:arxiv_app/models/paper.dart';
import 'package:arxiv_app/models/user.dart';
import 'package:arxiv_app/ui/views/home/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DownloadCard extends StatefulWidget {
  DownloadCard({this.paper, this.user});

  Paper paper;
  User user;

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
                      iconSize: ScreenUtil().setHeight(30),
                      icon: Icon(Icons.library_books),
                      onPressed: () async {
                        final result = await OpenFile.open('path');
                        if (result.type.toString() ==
                            'ResultType.fileNotFound') {
                          await Fluttertoast.showToast(
                              msg: 'File not found!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: ScreenUtil()
                                  .setSp(12, allowFontScalingSelf: true));
                        }
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    DateFormat('dd/MM/yyyy').format(
                                        widget.paper.datetimePaperPublished),
                                    style:
                                        Theme.of(context).textTheme.subtitle1)))
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
                              widget.user.downloads.remove(Bookmark(
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
                                  mediaUrl: 'path'));
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
                          icon: Icon(Icons.open_in_browser),
                          onPressed: () {
                            _launchInBrowser(widget.paper.htmlUrl);
                          })
                    ]))
          ],
        ))));
  }
}
