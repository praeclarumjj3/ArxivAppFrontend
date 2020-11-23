import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CreateBlogView extends StatefulWidget {
  static const String id = 'create_blog_view';

  @override
  CreateBlogViewState createState() => CreateBlogViewState();
}





class CreateBlogViewState extends State<CreateBlogView> {
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text('ArxivApp',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400)));
  }  
  Widget InputField(String helperText) {
    return Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10),
            ScreenUtil().setWidth(10), ScreenUtil().setWidth(10), 0),
        child: TextFormField(
          inputFormatters:[LengthLimitingTextInputFormatter(5000)],
          decoration: InputDecoration(
              hintText: helperText,
              contentPadding: EdgeInsets.all(15),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.blue[100]),  
        ));
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body : Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InputField('Enter Blog Title'),
            InputField('Enter Blog Body'),
            Padding(
              padding: EdgeInsets.all(16),
              child:FloatingActionButton.extended(
                onPressed: (){
                  
                },
                label:Text('Submit Entry'),

              ),              
            
            ),
          ],
        )
      )
    );
  }


}
