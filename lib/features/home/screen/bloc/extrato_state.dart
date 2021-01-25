part of 'extrato_cubit.dart';

abstract class ExtratoState extends Equatable {
  const ExtratoState();
}

class ExtratoInicialState extends ExtratoState {
  @override
  List<Object> get props => [];
}

class LoadingExtratoState extends ExtratoState {
  @override
  List<Object> get props => [];
}

class DadosValidoState extends ExtratoState {
  @override
  List<Object> get props => [];
}

class DadosInvalidoState extends ExtratoState {
  @override
  List<Object> get props => [];
}

class ExtratoUsuarioReturn extends ExtratoState {
  final ExtratoModel extratoModel;

  ExtratoUsuarioReturn({@required this.extratoModel});
  @override
  List<Object> get props => [];
}

class ExtratoNoInternet extends ExtratoState {
  @override
  List<Object> get props => [];
}

class ExtratoApiReturnError extends ExtratoState {
  @override
  List<Object> get props => [];
}
