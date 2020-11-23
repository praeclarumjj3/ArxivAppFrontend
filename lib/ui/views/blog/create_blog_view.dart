import 'package:arxiv_app/models/blog.dart';
import 'package:arxiv_app/viewmodels/blog/blog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../../base_view.dart';
import 'package:arxiv_app/ui/components/blog_card.dart';
import 'package:arxiv_app/models/blog.dart';

class CreateBlogView extends StatefulWidget {
  static const String id = 'blog_view';

  @override
  _CreateBlogViewState createState() => _CreateBlogViewState();
}

class _CreateBlogViewState extends State<CreateBlogView> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Blog>> papers;

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
        builder: (context, model, child) => Scaffold(
          appBar: buildAppBar(context),
          key: _scaffoldKey,
          body: Center(child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return BlogCard(
              
                );
            }
          )),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              
            }, 
            label: Text('Create Blog'),
            icon: Icon(Icons.add,),
        )
    ));
  }
}
