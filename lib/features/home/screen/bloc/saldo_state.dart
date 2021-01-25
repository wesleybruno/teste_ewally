part of 'saldo_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInicialState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class SaldoUsuarioReturn extends HomeState {
  final SaldoModel saldoModel;

  SaldoUsuarioReturn({@required this.saldoModel});
  @override
  List<Object> get props => [saldoModel];
}

class ApiReturnNoInternet extends HomeState {
  @override
  List<Object> get props => [];
}

class ApiReturnError extends HomeState {
  @override
  List<Object> get props => [];
}
