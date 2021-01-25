import 'package:get_it/get_it.dart';
import 'package:ewally/configs/utils/LocalStorage.dart';
import 'package:ewally/configs/utils/RequestApiProvider.dart';
import 'package:ewally/configs/utils/Validadores.dart';
import 'package:ewally/features/login/datasource/login_datasource.dart';
import 'package:ewally/features/login/repository/login_decode_helper.dart';
import 'package:ewally/features/login/repository/login_repository.dart';
import 'package:ewally/features/login/screen/bloc/login_cubit.dart';
import 'package:ewally/features/login/usecases/gravar_cabecalhos_local_usecase.dart';
import 'package:ewally/features/login/usecases/realizar_login_usecase.dart';

class LoginInjection {
  void injetar(GetIt dependencia) {
    dependencia.registerLazySingleton<ILoginDataSource>(
      () => LoginDataSource(
        apiProvider: dependencia<RequestApiProvider>(),
        localStorage: dependencia<ILocalStorage>(),
      ),
    );

    dependencia.registerLazySingleton<LoginDecodeHelper>(
      () => LoginDecodeHelper(),
    );

    dependencia.registerLazySingleton<LoginRepository>(
      () => LoginRepository(
        loginDecodeHelper: dependencia<LoginDecodeHelper>(),
        loginDataSource: dependencia<ILoginDataSource>(),
      ),
    );

    dependencia.registerLazySingleton<GravarCabecalhosLocalLoginUseCase>(
      () => GravarCabecalhosLocalLoginUseCase(
        loginRepository: dependencia<LoginRepository>(),
      ),
    );

    dependencia.registerLazySingleton<RealizarLoginUseCase>(
      () => RealizarLoginUseCase(
        loginRepository: dependencia<LoginRepository>(),
      ),
    );

    dependencia.registerFactory(
      () => LoginScreenCubit(
        validadorEmail: ValidadorEmail(),
        validadorTamanho: ValidadorTamanho(),
        realizarLoginUseCase: dependencia<RealizarLoginUseCase>(),
        gravarCabecalhosLocalLoginUseCase:
            dependencia<GravarCabecalhosLocalLoginUseCase>(),
      ),
    );
  }
}
