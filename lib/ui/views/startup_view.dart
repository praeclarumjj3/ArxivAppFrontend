import 'package:arxiv_app/viewmodels/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../base_view.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      onModelReady: (model) {
        return model.onModelReady();
      },
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
                  child: Container(
                      width: ScreenUtil().setWidth(340),
                      height: ScreenUtil().setHeight(400),
                      child: Center(
                          child: Text(
                        'ArxivAPP',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Colors.red),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
