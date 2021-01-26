import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/configs/utils/Validadores.dart';
import 'package:ewally/features/home/models/extrato_model.dart';
import 'package:ewally/features/home/screen/bloc/extrato_cubit.dart';
import 'package:ewally/features/home/usecases/buscar_extrato_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUseCase extends Mock implements BuscarExtratoUseCase {}

class MockValidadorFormatoData extends Mock implements ValidadorFormatoData {}

void main() {
  ExtratoCubit cubit;
  MockUseCase mockUseCase;
  MockValidadorFormatoData mockValidadorFormatoData;

  final tPeriodoInicio = '01-01-2021';
  final tPeriodoFim = '31-01-2021';
  final tExtratoModel = ExtratoModel();
  final tApiError = ApiError(statusCode: 400);
  final tSemInternetError = ApiError(statusCode: null);

  setUp(() {
    mockUseCase = MockUseCase();
    mockValidadorFormatoData = MockValidadorFormatoData();
    cubit = ExtratoCubit(
      buscarExtratoUseCase: mockUseCase,
      validadorFormatoData: mockValidadorFormatoData,
    );
  });

  tearDown(
    () => cubit.close(),
  );

  group('Cubit Extrato - Home Screen: ', () {
    test(
      'Verificar estado inicial',
      () {
        expect(
          cubit.state,
          ExtratoInicialState(),
        );
      },
    );

    blocTest<ExtratoCubit, ExtratoState>(
      'Sucesso - Validar Dados',
      build: () {
        when(
          mockValidadorFormatoData.isTextoValido(
            texto: tPeriodoInicio,
          ),
        ).thenAnswer(
          (_) => true,
        );

        when(
          mockValidadorFormatoData.isTextoValido(
            texto: tPeriodoFim,
          ),
        ).thenAnswer(
          (_) => true,
        );
        return cubit;
      },
      act: (bloc) async => cubit.validarDados(
        tPeriodoInicio,
        tPeriodoFim,
      ),
      expect: <ExtratoState>[
        DadosValidoState(),
      ],
    );

    blocTest<ExtratoCubit, ExtratoState>(
      'Falha - Validar Dados',
      build: () {
        when(
          mockValidadorFormatoData.isTextoValido(
            texto: tPeriodoInicio,
          ),
        ).thenAnswer(
          (_) => false,
        );

        when(
          mockValidadorFormatoData.isTextoValido(
            texto: tPeriodoFim,
          ),
        ).thenAnswer(
          (_) => true,
        );
        return cubit;
      },
      act: (bloc) async => cubit.validarDados(
        tPeriodoInicio,
        tPeriodoFim,
      ),
      expect: <ExtratoState>[
        DadosInvalidoState(),
      ],
    );

    blocTest<ExtratoCubit, ExtratoState>(
      'Sucesso - Buscar Extrato',
      build: () {
        when(
          mockUseCase.call(
            tPeriodoInicio,
            tPeriodoFim,
          ),
        ).thenAnswer(
          (_) async => Right(tExtratoModel),
        );

        return cubit;
      },
      act: (bloc) async => cubit.buscarExtrato(
        tPeriodoInicio,
        tPeriodoFim,
      ),
      expect: <ExtratoState>[
        LoadingExtratoState(),
        ExtratoUsuarioReturn(
          extratoModel: tExtratoModel,
        )
      ],
    );

    blocTest<ExtratoCubit, ExtratoState>(
      'Falha - Buscar Extrato',
      build: () {
        when(
          mockUseCase.call(
            tPeriodoInicio,
            tPeriodoFim,
          ),
        ).thenAnswer(
          (_) async => Left(tApiError),
        );

        return cubit;
      },
      act: (bloc) async => cubit.buscarExtrato(
        tPeriodoInicio,
        tPeriodoFim,
      ),
      expect: <ExtratoState>[
        LoadingExtratoState(),
        ExtratoApiReturnError(),
      ],
    );
    blocTest<ExtratoCubit, ExtratoState>(
      'Falha - Sem Internet',
      build: () {
        when(
          mockUseCase.call(
            tPeriodoInicio,
            tPeriodoFim,
          ),
        ).thenAnswer(
          (_) async => Left(tSemInternetError),
        );
        return cubit;
      },
      act: (bloc) async => cubit.buscarExtrato(
        tPeriodoInicio,
        tPeriodoFim,
      ),
      expect: <ExtratoState>[
        LoadingExtratoState(),
        ExtratoNoInternet(),
      ],
    );
  });
}
