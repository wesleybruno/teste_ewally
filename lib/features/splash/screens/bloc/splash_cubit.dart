import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ewally/features/splash/usecases/buscar_cabecalhos_local_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  BuscarCabecalhosLocalLoginUseCase _buscarCabecalhosLocalLoginUseCase;

  SplashCubit({
    @required
        BuscarCabecalhosLocalLoginUseCase buscarCabecalhosLocalLoginUseCase,
  })  : _buscarCabecalhosLocalLoginUseCase = buscarCabecalhosLocalLoginUseCase,
        super(SplashInitial());

  buscarDadosCabecalhos() async {
    await Future.delayed(new Duration(milliseconds: 2000), () {});
    final result = await _buscarCabecalhosLocalLoginUseCase();

    if (result.token != null) {
      return emit(PossuiDadosGravados());
    }

    emit(SemDadosGravados());
  }
}
