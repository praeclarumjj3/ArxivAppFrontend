import 'package:arxiv_app/locator.dart';
import 'package:arxiv_app/services/local_storage_service.dart';
import 'package:arxiv_app/ui/views/login/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:arxiv_app/enums/viewstate.dart';
import 'package:arxiv_app/viewmodels/login/login_viewmodel.dart';
import '../../base_view.dart';

class ProfileView extends StatefulWidget {
  static const String id = 'login_view';

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

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
    return BaseView<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: buildAppBar(context),
            body: SafeArea(
                child: model.state == ViewState.Busy
                    ? Center(
                        child: CircularProgressIndicator(
                          value: null,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      )
                    : Column(children: [
                        Expanded(
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(_localStorageService.userPic),
                              radius: ScreenUtil().setHeight(120),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.all(ScreenUtil().setWidth(20)),
                                  child: Text(
                                    _localStorageService.username,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.all(ScreenUtil().setWidth(20)),
                                  child: Text(
                                    _localStorageService.userEmail,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
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
                                          model.signOutGoogle();
                                          model.navigate(LoginView.id);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              ScreenUtil().setWidth(15),
                                              ScreenUtil().setHeight(15),
                                              ScreenUtil().setWidth(15),
                                              ScreenUtil().setHeight(15)),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.power_settings_new,
                                                color: Colors.white,
                                              ),
                                              Expanded(
                                                child: Text('Sign out',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button
                                                        .copyWith(
                                                            color:
                                                                Colors.white)),
                                              )
                                            ],
                                          ),
                                        ),
                                        color: Colors.red))
                              ],
                            )),
                      ]))));
  }
}
