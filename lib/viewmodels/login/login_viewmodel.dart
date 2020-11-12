import 'package:arxiv_app/services/navigation_service.dart';
import '../../locator.dart';
import '../base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigate(String id) {
    _navigationService.pushNamedAndRemoveUntil(id);
  }
}
