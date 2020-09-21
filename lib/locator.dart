import 'package:get_it/get_it.dart';
import 'services/local_storage_service.dart';
import 'services/navigation_service.dart';
import 'viewmodels/home/home_viewmodel.dart';
import 'viewmodels/startup_viewmodel.dart';


GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());

  var localStorageService = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageService);


  locator.registerFactory(() => StartUpViewModel());
  locator.registerFactory(() => HomeViewModel());

}