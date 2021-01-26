part of 'saldo_cubit.dart';

abstract class SaldoState extends Equatable {
  const SaldoState();
}

class HomeInicialState extends SaldoState {
  @override
  List<Object> get props => [];
}

class LoadingState extends SaldoState {
  @override
  List<Object> get props => [];
}

class SaldoUsuarioReturn extends SaldoState {
  final SaldoModel saldoModel;

  SaldoUsuarioReturn({@required this.saldoModel});
  @override
  List<Object> get props => [saldoModel];
}

class ApiReturnNoInternet extends SaldoState {
  @override
  List<Object> get props => [];
}

class ApiReturnError extends SaldoState {
  @override
  List<Object> get props => [];
}
