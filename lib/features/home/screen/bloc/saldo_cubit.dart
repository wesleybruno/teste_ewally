import 'package:equatable/equatable.dart';
import 'package:ewally/configs/utils/UnauthorizedMixin.dart';
import 'package:ewally/features/home/models/saldo_model.dart';
import 'package:ewally/features/home/usecases/buscar_saldo_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'saldo_state.dart';

class SaldoCubit extends Cubit<HomeState> with UnauthorizedMixin {
  final BuscarSaldoUseCase _buscarSaldoUseCase;
  SaldoCubit({
    @required BuscarSaldoUseCase buscarSaldoUseCase,
  })  : _buscarSaldoUseCase = buscarSaldoUseCase,
        super(
          HomeInicialState(),
        );

  void buscarSaldo() async {
    emit(LoadingState());
    final result = await _buscarSaldoUseCase();

    result.fold((error) {
      if (error.statusCode == null) {
        return emit(ApiReturnNoInternet());
      }

      if (error.statusCode == 401) {
        redirecionarLogin();
      }
      emit(ApiReturnError());
    }, (saldoUsuario) {
      return emit(SaldoUsuarioReturn(saldoModel: saldoUsuario));
    });
  }
}
