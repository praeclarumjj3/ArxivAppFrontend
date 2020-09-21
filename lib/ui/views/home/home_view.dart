import 'package:arxiv_app/viewmodels/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';

class HomeView extends StatefulWidget {
  static const String id = 'home_view';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'Home View',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
