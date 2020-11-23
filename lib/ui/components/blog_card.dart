import 'dart:ui';
import 'package:arxiv_app/models/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

// ignore: must_be_immutable
class BlogCard extends StatefulWidget {
  BlogCard({this.blog});

  Blog blog;


  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  final Title = Container(
    
    child: Text('blogName',style: TextStyle(fontSize: 50,)) 
  );
  final Author = Container(

    child: Text('blogAuthor',style: TextStyle(fontSize: 20,))
  );
  
  final Body = Container(
    child: Text('blogBody',style: TextStyle(fontSize: 35,))
  );

  final VoteSection = Container(

    child: Row(
      children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_drop_up,size: 50,color: Colors.blue[800],), onPressed: null),
        Divider(
            thickness: ScreenUtil().setWidth(3),
        ),
        Text('  #votes  '),
        Divider(
            thickness: ScreenUtil().setWidth(3),
        ),        
        IconButton(icon: Icon(Icons.arrow_drop_down,size:50,color: Colors.blue[800]), onPressed: null)

      ],
    )
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
                Divider(
                    thickness: ScreenUtil().setWidth(3),
                ),
                Author,
                Divider(
                    thickness: ScreenUtil().setWidth(3),
                ),                
                Body,
                Divider(
                    thickness: ScreenUtil().setWidth(3),
                ),                
                VoteSection,
              
              ],
          ),
        ),
      ),
    );
  }
}
