import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ewally/configs/utils/Validadores.dart';
import 'package:ewally/features/login/usecases/gravar_cabecalhos_local_usecase.dart';
import 'package:ewally/features/login/usecases/realizar_login_usecase.dart';

part 'login_state.dart';

class LoginScreenCubit extends Cubit<LoginState> {
  final RealizarLoginUseCase _realizarLoginUseCase;
  final GravarCabecalhosLocalLoginUseCase _gravarCabecalhosLocalLoginUseCase;
  final ValidadorTamanho _validadorTamanho;

  LoginScreenCubit({
    @required
        GravarCabecalhosLocalLoginUseCase gravarCabecalhosLocalLoginUseCase,
    @required RealizarLoginUseCase realizarLoginUseCase,
    @required ValidadorTamanho validadorTamanho,
  })  : _gravarCabecalhosLocalLoginUseCase = gravarCabecalhosLocalLoginUseCase,
        _realizarLoginUseCase = realizarLoginUseCase,
        _validadorTamanho = validadorTamanho,
        super(
          LoginInicialState(),
        );

  bool _validarLogin(String username) =>
      _validadorTamanho.isTextoValido(texto: username);

  bool _validarSenha(String senha) =>
      _validadorTamanho.isTextoValido(texto: senha);

  void validarDados(String email, String senha) {
    final loginValido = _validarLogin(email);
    final senhaValida = _validarSenha(senha);

    if (loginValido && senhaValida) {
      emit(DadosValidoState());
    } else {
      emit(DadosInvalidoState());
    }
  }

  void realizarLogin(String username, String password) async {
    emit(LoadingState());
    final result = await _realizarLoginUseCase(username, password);

    result.fold((error) {
      if (error.statusCode == null) {
        return emit(ApiReturnNoInternet());
      }
      emit(CredenciaisInvalidasState(
        mensagem: error.message,
      ));
    }, (usuario) {
      _gravarCabecalhosLocalLoginUseCase(
        usuario.token,
      );
      return emit(CredenciaisValidasState());
    });
  }
}
