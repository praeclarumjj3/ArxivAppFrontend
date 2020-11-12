import 'dart:async';
import 'package:arxiv_app/services/navigation_service.dart';
import 'package:arxiv_app/ui/views/login/login_view.dart';
import '../locator.dart';
import 'base_viewmodel.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> onModelReady() async {
    await Future.delayed(Duration(seconds: 2));
    return _navigationService.pushNamedAndRemoveUntil(LoginView.id);
  }
}
