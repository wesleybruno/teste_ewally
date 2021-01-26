import 'package:ewally/configs/utils/RequestApiProvider.dart';
import 'package:ewally/configs/utils/Validadores.dart';
import 'package:ewally/features/home/datasource/saldo_datasource.dart';
import 'package:ewally/features/home/repository/extrato_decode_helper.dart';
import 'package:ewally/features/home/repository/saldo_decode_helper.dart';
import 'package:ewally/features/home/repository/saldo_repository.dart';
import 'package:ewally/features/home/screen/bloc/extrato_cubit.dart';
import 'package:ewally/features/home/screen/bloc/saldo_cubit.dart';
import 'package:ewally/features/home/usecases/buscar_extrato_usecase.dart';
import 'package:ewally/features/home/usecases/buscar_saldo_usecase.dart';
import 'package:get_it/get_it.dart';

class HomeInjection {
  void injetar(GetIt dependencia) {
    dependencia.registerLazySingleton<ExtratoDecodeHelper>(
      () => ExtratoDecodeHelper(),
    );

    dependencia.registerLazySingleton<SaldoDecodeHelper>(
      () => SaldoDecodeHelper(),
    );

    dependencia.registerLazySingleton<SaldoDataSource>(
      () => SaldoDataSource(
        apiProvider: dependencia<RequestApiProvider>(),
      ),
    );

    dependencia.registerLazySingleton<SaldoRepository>(
      () => SaldoRepository(
        extratoDecodeHelper: dependencia<ExtratoDecodeHelper>(),
        saldoDataSource: dependencia<SaldoDataSource>(),
        saldoDecodeHelper: dependencia<SaldoDecodeHelper>(),
      ),
    );

    dependencia.registerLazySingleton<BuscarExtratoUseCase>(
      () => BuscarExtratoUseCase(
        saldoRepository: dependencia<SaldoRepository>(),
      ),
    );

    dependencia.registerLazySingleton<BuscarSaldoUseCase>(
      () => BuscarSaldoUseCase(
        saldoRepository: dependencia<SaldoRepository>(),
      ),
    );

    dependencia.registerFactory(
      () => SaldoCubit(
        buscarSaldoUseCase: dependencia<BuscarSaldoUseCase>(),
      ),
    );

    dependencia.registerFactory(
      () => ExtratoCubit(
        buscarExtratoUseCase: dependencia<BuscarExtratoUseCase>(),
        validadorFormatoData: ValidadorFormatoData(),
      ),
    );
  }
}
