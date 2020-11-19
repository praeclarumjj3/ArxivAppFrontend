import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/ui/views/home/home_view.dart';
import 'package:arxiv_app/viewmodels/login/login_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base_view.dart';

class LoginView extends StatefulWidget {
  static const String id = 'login_view';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
            key: _scaffoldKey,
            body: model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(
                      value: null,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(15),
                              ScreenUtil().setWidth(15),
                              ScreenUtil().setWidth(15),
                              ScreenUtil().setWidth(15)),
                          child: Text(
                            'arxiv.org',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    color: Colors.red,
                                    fontStyle: FontStyle.normal),
                          )),
                      SizedBox(
                        height: ScreenUtil().setHeight(40),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(30),
                              ScreenUtil().setHeight(20),
                              ScreenUtil().setWidth(30),
                              ScreenUtil().setHeight(20)),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(15))),
                              onPressed: () {
                                model.signInWithGoogle().then((result) {
                                  if (result != null) {
                                    model.navigate(HomeView.id);
                                  }
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(15),
                                    ScreenUtil().setHeight(15),
                                    ScreenUtil().setWidth(15),
                                    ScreenUtil().setHeight(15)),
                                child: Row(
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage('assets/google.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    Expanded(
                                      child: Text('Login with Google',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .button),
                                    )
                                  ],
                                ),
                              ),
                              color: Colors.black26))
                    ],
                  )));
  }
}
