import 'package:arxiv_app/ui/views/home/home_view.dart';
import 'package:arxiv_app/viewmodels/login/login_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import '../../base_view.dart';

class LoginView extends StatefulWidget {
  static const String id = 'login_view';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> fetchFiles() async {
    var hlp = OAuth2Helper(GoogleOAuth2Client(
        redirectUri: 'com.teranet.app:/oauth2redirect',
        customUriScheme: 'com.teranet.app'));

    hlp.setAuthorizationParams(
        grantType: OAuth2Helper.AUTHORIZATION_CODE,
        clientId: 'XXX-XXX-XXX',
        clientSecret: 'XXX-XXX-XXX',
        scopes: ['https://www.googleapis.com/auth/drive.readonly']);

    var resp = await hlp.get('https://www.googleapis.com/drive/v3/files');

    print(resp.body);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
            key: _scaffoldKey,
            body: Column(
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
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          color: Colors.red, fontStyle: FontStyle.normal),
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
                        onPressed: () {
                          model.navigate(HomeView.id);
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
                                    style: Theme.of(context).textTheme.button),
                              )
                            ],
                          ),
                        ),
                        color: Colors.black26))
              ],
            )));
  }
}
