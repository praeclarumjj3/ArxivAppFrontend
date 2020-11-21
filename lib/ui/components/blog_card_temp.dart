import 'dart:io';
import 'dart:math';
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
  final Title = Container(
    
    child: Text('blogName',) 
  );
  final Author = Container(

    child: Text('blogAuthor',style: TextStyle(fontSize: 20,))
  );
  
  final Body = Container(
    child: Text('blogBody')
  );
  final VoteSection = Container(

    child: Text('votes')
  );

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
