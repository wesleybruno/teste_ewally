import 'package:ewally/configs/routes/app/i_app_navigator.dart';
import 'package:ewally/features/login/usecases/limpar_cabecalhos_usecase.dart';
import 'package:ewally/injection_container.dart';

mixin UnauthorizedMixin {
  void redirecionarLogin() {
    dependencia<IAppNavigator>().irParaLogin(podeVoltar: false);
    dependencia<LimparCabecalhosLocalLoginUseCase>()..call();
  }
}
