import 'package:arxiv_app/ui/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'views/home/home_view.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeView.id:
        return MaterialPageRoute(
            builder: (_) => HomeView(
                  index: 0,
                  search: 'DEAP',
                ));
      case LoginView.id:
        return MaterialPageRoute(builder: (_) => LoginView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
