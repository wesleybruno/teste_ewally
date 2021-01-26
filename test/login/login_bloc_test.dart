import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/configs/utils/Validadores.dart';
import 'package:ewally/features/login/model/token_model.dart';
import 'package:ewally/features/login/screen/bloc/login_cubit.dart';
import 'package:ewally/features/login/usecases/gravar_cabecalhos_local_usecase.dart';
import 'package:ewally/features/login/usecases/realizar_login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUseCase extends Mock implements RealizarLoginUseCase {}

class MockGravarCabecalhosLocalLoginUseCase extends Mock
    implements GravarCabecalhosLocalLoginUseCase {}

class MockValidadorTamanho extends Mock implements ValidadorTamanho {}

void main() {
  LoginScreenCubit cubit;
  MockUseCase mockUseCase;
  MockGravarCabecalhosLocalLoginUseCase mockGravarCabecalhosLocalLoginUseCase;
  MockValidadorTamanho mockValidadorTamanho;

  final tLogin = 'loginTeste';
  final tSenha = 'senhaTeste';
  final tToken = '12312313';
  final tTokenModel = TokenModel(token: tToken);
  final tApiError = ApiError(statusCode: 400);
  final tSemInternetError = ApiError(statusCode: null);

  setUp(() {
    mockUseCase = MockUseCase();
    mockGravarCabecalhosLocalLoginUseCase =
        MockGravarCabecalhosLocalLoginUseCase();
    mockValidadorTamanho = MockValidadorTamanho();
    cubit = LoginScreenCubit(
      gravarCabecalhosLocalLoginUseCase: mockGravarCabecalhosLocalLoginUseCase,
      realizarLoginUseCase: mockUseCase,
      validadorTamanho: mockValidadorTamanho,
    );
  });

  tearDown(
    () => cubit.close(),
  );

  group('Cubit Login Screen: ', () {
    test(
      'Verificar estado inicial',
      () {
        expect(
          cubit.state,
          LoginInicialState(),
        );
      },
    );

    blocTest<LoginScreenCubit, LoginState>(
      'Sucesso - Validar Dados',
      build: () {
        when(
          mockValidadorTamanho.isTextoValido(texto: tLogin),
        ).thenAnswer(
          (_) => true,
        );

        when(
          mockValidadorTamanho.isTextoValido(texto: tSenha),
        ).thenAnswer(
          (_) => true,
        );
        return cubit;
      },
      act: (bloc) async => cubit.validarDados(tLogin, tSenha),
      expect: <LoginState>[
        DadosValidoState(),
      ],
    );

    blocTest<LoginScreenCubit, LoginState>(
      'Falha - Validar Dados',
      build: () {
        when(
          mockValidadorTamanho.isTextoValido(texto: tLogin),
        ).thenAnswer(
          (_) => false,
        );

        when(
          mockValidadorTamanho.isTextoValido(texto: tSenha),
        ).thenAnswer(
          (_) => true,
        );
        return cubit;
      },
      act: (bloc) async => cubit.validarDados(tLogin, tSenha),
      expect: <LoginState>[
        DadosInvalidoState(),
      ],
    );
    blocTest<LoginScreenCubit, LoginState>(
      'Sucesso - Realizar Login',
      build: () {
        when(
          mockUseCase.call(tLogin, tSenha),
        ).thenAnswer(
          (_) async => Right(tTokenModel),
        );
        return cubit;
      },
      act: (bloc) async => cubit.realizarLogin(tLogin, tSenha),
      expect: <LoginState>[
        LoadingState(),
        CredenciaisValidasState(),
      ],
    );

    blocTest<LoginScreenCubit, LoginState>(
      'Falha - Realizar Login',
      build: () {
        when(
          mockUseCase.call(tLogin, tSenha),
        ).thenAnswer(
          (_) async => Left(tApiError),
        );
        return cubit;
      },
      act: (bloc) async => cubit.realizarLogin(tLogin, tSenha),
      expect: <LoginState>[
        LoadingState(),
        CredenciaisInvalidasState(),
      ],
    );

    blocTest<LoginScreenCubit, LoginState>(
      'Falha - Sem Internet',
      build: () {
        when(
          mockUseCase.call(tLogin, tSenha),
        ).thenAnswer(
          (_) async => Left(tSemInternetError),
        );
        return cubit;
      },
      act: (bloc) async => cubit.realizarLogin(tLogin, tSenha),
      expect: <LoginState>[
        LoadingState(),
        ApiReturnNoInternet(),
      ],
    );
  });
}
