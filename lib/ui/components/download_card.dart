import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

// ignore: must_be_immutable
class DownloadCard extends StatelessWidget {
  DownloadCard({this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Row(
      children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          IconButton(
              color: Colors.blueAccent,
              iconSize: ScreenUtil().setHeight(150),
              icon: Icon(Icons.file_download),
              onPressed: () {})
        ]),
        Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Text('Paper', style: Theme.of(context).textTheme.headline2),
              Divider(
                thickness: ScreenUtil().setWidth(5),
              ),
              Text('Author', style: Theme.of(context).textTheme.headline2)
            ])),
        Align(
            alignment: Alignment.centerRight,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      color: Colors.red,
                      iconSize: ScreenUtil().setHeight(30),
                      icon: Icon(Icons.star),
                      onPressed: () {}),
                  IconButton(
                      color: Colors.blue,
                      iconSize: ScreenUtil().setHeight(30),
                      icon: Icon(Icons.open_in_browser),
                      onPressed: () {})
                ]))
      ],
    )));
  }
}
