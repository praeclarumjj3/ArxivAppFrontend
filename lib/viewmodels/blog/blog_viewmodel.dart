import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/models/blog.dart';
import 'package:arxiv_app/services/blog_service.dart';
import 'package:arxiv_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';
import '../base_viewmodel.dart';

class BlogViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final BlogService _blogService = locator<BlogService>();

  void navigate(String id) {
    _navigationService.pushNamedAndRemoveUntil(id);
  }

  List<Blog> _blogs;

  Future getBlogs() async {
    setState(ViewState.Busy);
    dynamic result = await _blogService.getBlogs();
    if (result == false) {
      setState(ViewState.Error);
      setErrorMessage('Blogs not found!');
    } else {
      setBlogs(result);
      setState(ViewState.Idle);
    }
  }

  void setBlogs(List<Blog> blogs) {
    _blogs = blogs;
    notifyListeners();
  }

  void createBlog(String title, String body) {
    dynamic result = _blogService.createBlog(title, body);
    if (result == false) {
      Fluttertoast.showToast(
          msg: 'Could not create Blog entry!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true));
    } else {
      getBlogs();
    }
  }

  void voteBlog(int id, String action) {
    dynamic result = _blogService.voteBlog(id, action);
    if (result == false) {
      Fluttertoast.showToast(
          msg: 'Could not vote!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true));
    } else {
      getBlogs();
    }
  }

  List<Blog> get blogs => _blogs;
}
