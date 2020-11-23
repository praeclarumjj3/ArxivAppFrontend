import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/ui/views/blog/create_blog_view.dart';
import 'package:arxiv_app/ui/views/home/home_view.dart';
import 'package:arxiv_app/viewmodels/blog/blog_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';
import 'package:arxiv_app/ui/components/blog_card.dart';

class BlogView extends StatefulWidget {
  static const String id = 'blog_view';

  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text('ArxivApp',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.white, fontWeight: FontWeight.w400)),
      leading: IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeView(
                          index: 4,
                          search: 'DEAP',
                        )),
                (Route<dynamic> route) => false);
          }),
      centerTitle: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BlogViewModel>(
        onModelReady: (model) {
          model.getBlogs();
        },
        builder: (context, model, child) => Scaffold(
            appBar: buildAppBar(context),
            key: _scaffoldKey,
            body: Center(
                child: Center(
                    child: model.state == ViewState.Busy
                        ? Center(
                            child: CircularProgressIndicator(
                              value: null,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                          )
                        : model.state == ViewState.Error
                            ? Text(
                                'No Blogs!',
                                style: Theme.of(context).textTheme.bodyText2,
                                textAlign: TextAlign.center,
                              )
                            : ListView.builder(
                                itemCount: model.blogs.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return BlogCard(
                                      blog: model.blogs[index], model: model);
                                }))),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateBlogView(
                            model: model,
                          )),
                );
              },
              label: Text('Create Blog'),
              icon: Icon(
                Icons.add,
              ),
            )));
  }
}
