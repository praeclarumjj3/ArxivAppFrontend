import 'package:arxiv_app/ui/views/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'locator.dart';
import 'services/navigation_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ui/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(GetMaterialApp(
      home: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red, //or set color with: Color(0xFF0000FF)
    ));
    ScreenUtil.init(context, width: 360, height: 746, allowFontScaling: true);
    return MaterialApp(
      title: 'Arxiv App',
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: CustomRouter.generateRoute,
      theme: ThemeData(
          primaryColor: Colors.red,
          indicatorColor: Colors.black,
          backgroundColor: Colors.white,
          primarySwatch: Colors.red,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: ScreenUtil().setSp(50, allowFontScalingSelf: true),
              fontWeight: FontWeight.w600,
            ),
            bodyText2: TextStyle(
              fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
              fontWeight: FontWeight.w300,
            ),
            headline2: TextStyle(
              fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
              fontWeight: FontWeight.w300,
            ),
            bodyText1: TextStyle(
                fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true),
                fontWeight: FontWeight.w600,
                color: Colors.red),
          )),
      home: StartUpView(),
    );
  }
}
