import 'dart:ui';
import 'package:arxiv_app/models/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:arxiv_app/services/blog_service.dart';

// ignore: must_be_immutable
class BlogCard extends StatefulWidget {
  BlogCard({this.blog});

  Blog blog;

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  final Title = Container(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('How To Get A Chapo?',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))));
  final Author = Container(
      child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5, bottom: 5),
          child: Text('Ayushman Tripathy',
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic))));

  final Body = Container(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
              'Contact Shasha Bhai. Ask Him. Bug Him. Untill he gets frustrated and gives a chapo.',
              style: TextStyle(
                fontSize: 20,
              ))));

  //Utilities to UpVote and DownVote Blogs
  void UpVoteBlog(String id) {
    BlogService().voteBlog(id, 'up');
  }

  void DownVoteBlog(String id) {
    BlogService().voteBlog(id, 'down');
  }

  void GetNumberOfVotes(String id) {
    BlogService().getNumberOfVotes(id);
  }

  final VoteSection = Container(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: Colors.blue[600],
                ),
                onPressed: () {},//funtion call to UpVote here, implemented above
              ),
              VerticalDivider(
                thickness: ScreenUtil().setWidth(10),
                color: Colors.black,
              ),
              Text('  #votes  ',  //here add function call to get vote number, implemented above
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
              VerticalDivider(
                thickness: ScreenUtil().setWidth(10),
                color: Colors.black,
              ),
              IconButton(
                  icon: Icon(Icons.thumb_down, color: Colors.red[700]),
                  onPressed: () {}) //Funtion call to DownVote here, implemented above
            ],
          )));

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
              Title,
              Author,
              Body,
              VoteSection,
            ],
          ),
        ),
      ),
    );
  }
}
