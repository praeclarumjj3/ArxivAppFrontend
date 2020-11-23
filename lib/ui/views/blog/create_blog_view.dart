import 'package:arxiv_app/ui/views/blog/blog_view.dart';
import 'package:arxiv_app/viewmodels/blog/blog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';

// ignore: must_be_immutable
class CreateBlogView extends StatefulWidget {
  static const String id = 'create_blog_view';

  CreateBlogView({this.model});

  BlogViewModel model;

  @override
  CreateBlogViewState createState() => CreateBlogViewState();
}

class CreateBlogViewState extends State<CreateBlogView> {
  TextEditingController controllerName;
  TextEditingController controllerDescription;

  @override
  // ignore: must_call_super
  void initState() {
    controllerName = TextEditingController();
    controllerDescription = TextEditingController();
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('ArxivApp',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400)));
  }

  Widget InputField(String helperText, TextEditingController controllerS) {
    return Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10),
            ScreenUtil().setWidth(10), ScreenUtil().setWidth(10), 0),
        child: TextFormField(
          controller: controllerS,
          maxLength: 5000,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: Theme.of(context).textTheme.button,
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
        body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InputField('Enter Blog Title', controllerName),
                InputField('Enter Blog Body', controllerDescription),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      print(controllerName.text);
                      print(controllerDescription.text);
                      widget.model.createBlog(
                          controllerName.text, controllerDescription.text);
                      widget.model.navigate(BlogView.id);
                    },
                    label: Text('Submit Entry'),
                  ),
                ),
              ],
            )));
  }
}
