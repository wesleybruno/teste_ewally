import 'package:ewally/configs/client/check_connectivty.dart';
import 'package:ewally/configs/client/custom_dio.dart';
import 'package:ewally/configs/routes/app/app_navigator.dart';
import 'package:ewally/configs/routes/app/i_app_navigator.dart';
import 'package:ewally/configs/utils/LocalStorage.dart';
import 'package:ewally/configs/utils/RequestApiProvider.dart';
import 'package:ewally/features/login/injection_container.dart';
import 'package:ewally/features/splash/injection_container.dart';
import 'package:get_it/get_it.dart';

final dependencia = GetIt.instance;

Future<void> init() async {
  dependencia.registerFactory(
    () => LocalConnectivity(),
  );

  dependencia.registerFactory(
    () => CustomDio(),
  );

  dependencia.registerLazySingleton<ILocalStorage>(
    () => SharedPref(),
  );

  dependencia.registerFactory(
    () => RequestApiProvider(
      customDio: dependencia<CustomDio>(),
    ),
  );

  dependencia.registerSingleton<IAppNavigator>(
    AppNavigator(),
  );

  SplashInjection()..injetar(dependencia);
  LoginInjection()..injetar(dependencia);
}
