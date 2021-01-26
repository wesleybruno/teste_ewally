import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/features/home/models/saldo_model.dart';
import 'package:ewally/features/home/screen/bloc/saldo_cubit.dart';
import 'package:ewally/features/home/usecases/buscar_saldo_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUseCase extends Mock implements BuscarSaldoUseCase {}

void main() {
  SaldoCubit cubit;
  MockUseCase mockUseCase;

  final tSaldoModel = SaldoModel();
  final tApiError = ApiError(statusCode: 400);
  final tSemInternetError = ApiError(statusCode: null);

  setUp(() {
    mockUseCase = MockUseCase();
    cubit = SaldoCubit(buscarSaldoUseCase: mockUseCase);
  });

  tearDown(
    () => cubit.close(),
  );

  group('Cubit Saldo - Home Screen: ', () {
    test(
      'Verificar estado inicial',
      () {
        expect(
          cubit.state,
          HomeInicialState(),
        );
      },
    );

    blocTest<SaldoCubit, SaldoState>(
      'Sucesso - Buscar Saldo',
      build: () {
        when(
          mockUseCase.call(),
        ).thenAnswer(
          (_) async => Right(tSaldoModel),
        );

        return cubit;
      },
      act: (bloc) async => cubit.buscarSaldo(),
      expect: <SaldoState>[
        LoadingState(),
        SaldoUsuarioReturn(saldoModel: tSaldoModel)
      ],
    );

    blocTest<SaldoCubit, SaldoState>(
      'Falha - Buscar Saldo',
      build: () {
        when(
          mockUseCase.call(),
        ).thenAnswer(
          (_) async => Left(tApiError),
        );

        return cubit;
      },
      act: (bloc) async => cubit.buscarSaldo(),
      expect: <SaldoState>[
        LoadingState(),
        ApiReturnError(),
      ],
    );
    blocTest<SaldoCubit, SaldoState>(
      'Falha - Sem Internet',
      build: () {
        when(
          mockUseCase.call(),
        ).thenAnswer(
          (_) async => Left(tSemInternetError),
        );
        return cubit;
      },
      act: (bloc) async => cubit.buscarSaldo(),
      expect: <SaldoState>[
        LoadingState(),
        ApiReturnNoInternet(),
      ],
    );
  });
}
