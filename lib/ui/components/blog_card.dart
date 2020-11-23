import 'dart:ui';
import 'package:arxiv_app/models/blog.dart';
import 'package:arxiv_app/viewmodels/blog/blog_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

// ignore: must_be_immutable
class BlogCard extends StatefulWidget {
  BlogCard({this.blog, this.model});

  Blog blog;
  BlogViewModel model;

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  int _votes;

  @override
  void initState() {
    super.initState();
    _votes = widget.blog.votes;
  }

  Widget Title() {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(widget.blog.title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))));
  }

  Widget Author() {
    return Container(
        child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: 5, bottom: 5),
            child: Text(widget.blog.author,
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic))));
  }

  Widget Body() {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(widget.blog.body,
                style: TextStyle(
                  fontSize: 20,
                ))));
  }

  //Utilities to UpVote and DownVote Blogs
  void UpVoteBlog(int id) {
    widget.model.voteBlog(id, 'up');
    setState(() {
      _votes += 1;
    });
  }

  void DownVoteBlog(int id) {
    widget.model.voteBlog(id, 'down');
    setState(() {
      _votes -= 1;
    });
  }

  Widget VoteSection() {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.blue[600],
                  ),
                  onPressed: () {
                    UpVoteBlog(widget.blog.id);
                  }, //funtion call to UpVote here, implemented above
                ),
                VerticalDivider(
                  thickness: ScreenUtil().setWidth(10),
                  color: Colors.black,
                ),
                Text(_votes.toString(),
                    //here add function call to get vote number, implemented above
                    style:
                        TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                VerticalDivider(
                  thickness: ScreenUtil().setWidth(10),
                  color: Colors.black,
                ),
                IconButton(
                    icon: Icon(Icons.thumb_down, color: Colors.red[700]),
                    onPressed: () {
                      DownVoteBlog(widget.blog.id);
                    })
                //Funtion call to DownVote here, implemented above
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10),
          ScreenUtil().setWidth(10), ScreenUtil().setWidth(10), 0),
      child: Container(
        width: double.maxFinite,
        child: Card(
          borderOnForeground: true,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Title(),
              Author(),
              Body(),
              VoteSection(),
            ],
          ),
        ),
      ),
    );
  }
}
