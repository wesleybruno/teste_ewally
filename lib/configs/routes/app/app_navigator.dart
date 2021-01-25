import 'package:ewally/configs/routes/app/app_routes.dart';
import 'package:ewally/configs/routes/app/i_app_navigator.dart';
import 'package:ewally/configs/routes/routes.dart';
import 'package:sailor/sailor.dart';

class AppNavigator implements IAppNavigator {
  @override
  irParaHome({bool podeVoltar = false}) {
    Routes.sailor.navigate(
      AppRoutes.home,
      navigationType:
          podeVoltar ? NavigationType.push : NavigationType.popAndPushNamed,
    );
  }

  @override
  irParaLogin({bool podeVoltar = false}) {
    Routes.sailor.navigate(
      AppRoutes.login,
      navigationType:
          podeVoltar ? NavigationType.push : NavigationType.popAndPushNamed,
    );
  }
}
