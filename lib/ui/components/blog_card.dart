import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:arxiv_app/models/blog.dart';
import 'package:arxiv_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

// ignore: must_be_immutable
class BlogCard extends StatefulWidget {
  BlogCard({this.blog, this.user});

  Blog blog;
  User user;

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {




  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.fromLTRB(ScreenUtil().setWidth(10),
                  ScreenUtil().setWidth(10), ScreenUtil().setWidth(10), 0),
        child: Container(
          child: Card(
                  child: Row(
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                          ]
                      ),
                      Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(widget.blog.title,
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
                          ])
                        ),
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
                                      } else {
                                        setState(() {
                                          _isBookmarked = true;
                                          widget.user.bookmarks.add(Bookmark(
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
                                      }
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
          ))
        ));
  }
}
