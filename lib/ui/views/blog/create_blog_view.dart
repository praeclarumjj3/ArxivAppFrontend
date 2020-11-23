import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
=======
import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../../base_view.dart';
import 'package:arxiv_app/ui/components/blog_card.dart';
>>>>>>> 4b5884a46d4540b875d6a5a3f875c83291b2b99e

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
