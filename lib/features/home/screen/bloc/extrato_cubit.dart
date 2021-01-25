import 'package:equatable/equatable.dart';
import 'package:ewally/configs/utils/UnauthorizedMixin.dart';
import 'package:ewally/features/home/models/extrato_model.dart';
import 'package:ewally/features/home/usecases/buscar_extrato_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ewally/configs/utils/Validadores.dart';

part 'extrato_state.dart';

class ExtratoCubit extends Cubit<ExtratoState> with UnauthorizedMixin {
  final ValidadorFormatoData _validadorTamanho;
  final BuscarExtratoUseCase _buscarExtratoUseCase;
  ExtratoCubit({
    @required ValidadorFormatoData validadorTamanho,
    @required BuscarExtratoUseCase buscarExtratoUseCase,
  })  : _validadorTamanho = validadorTamanho,
        _buscarExtratoUseCase = buscarExtratoUseCase,
        super(
          ExtratoInicialState(),
        );

  void validarDados(String periodoInicio, String periodoFim) {
    final periodoInicioValido =
        _validadorTamanho.isTextoValido(texto: periodoInicio);
    final periodoFimValido = _validadorTamanho.isTextoValido(texto: periodoFim);
    if (periodoInicioValido && periodoFimValido) {
      emit(DadosValidoState());
    } else {
      emit(DadosInvalidoState());
    }
  }

  void buscarExtrato(String periodoInicio, String periodoFim) async {
    emit(LoadingExtratoState());
    final result = await _buscarExtratoUseCase(periodoInicio, periodoFim);

    result.fold((error) {
      if (error.statusCode == null) {
        return emit(ExtratoNoInternet());
      }

      if (error.statusCode == 401) {
        redirecionarLogin();
      }
      emit(ExtratoApiReturnError());
    }, (extratoUsuario) {
      return emit(ExtratoUsuarioReturn(
        extratoModel: extratoUsuario,
      ));
    });
  }
}
