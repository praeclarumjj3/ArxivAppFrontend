import 'package:arxiv_app/enums/viewstate.dart';
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
        title: Text('ArxivApp',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400)));
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>
                //       ),
                // );
              },
              label: Text('Create Blog'),
              icon: Icon(
                Icons.add,
              ),
            )));
  }
}
