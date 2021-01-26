import 'package:bloc_test/bloc_test.dart';
import 'package:ewally/features/login/model/token_model.dart';
import 'package:ewally/features/splash/screens/bloc/splash_cubit.dart';
import 'package:ewally/features/splash/usecases/buscar_cabecalhos_local_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUseCase extends Mock implements BuscarCabecalhosLocalLoginUseCase {}

void main() {
  SplashCubit cubit;
  MockUseCase mockUseCase;

  final String tToken = '1213132';
  TokenModel tTokenModel = TokenModel(token: tToken);

  setUp(() {
    mockUseCase = MockUseCase();
    cubit = SplashCubit(
      buscarCabecalhosLocalLoginUseCase: mockUseCase,
    );
  });

  tearDown(
    () => cubit.close(),
  );

  group('Cubit Splash Screen: ', () {
    test(
      'Verificar estado inicial',
      () {
        expect(
          cubit.state,
          SplashInitial(),
        );
      },
    );

    blocTest<SplashCubit, SplashState>(
      'Sucesso - Buscar Token Local',
      build: () {
        when(
          mockUseCase.call(),
        ).thenAnswer(
          (_) async => tTokenModel,
        );
        return cubit;
      },
      act: (bloc) async => cubit.buscarDadosCabecalhos(),
      expect: <SplashState>[
        PossuiDadosGravados(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'Falha - Buscar Token Local',
      build: () {
        when(
          mockUseCase.call(),
        ).thenAnswer(
          (_) async => TokenModel(),
        );
        return cubit;
      },
      act: (bloc) async => cubit.buscarDadosCabecalhos(),
      expect: <SplashState>[
        SemDadosGravados(),
      ],
    );
  });
}
