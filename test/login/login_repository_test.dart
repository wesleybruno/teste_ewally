import 'package:dartz/dartz.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/features/login/datasource/login_datasource.dart';
import 'package:ewally/features/login/model/token_model.dart';
import 'package:ewally/features/login/repository/login_decode_helper.dart';
import 'package:ewally/features/login/repository/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginDataSource extends Mock implements ILoginDataSource {}

class MockLoginDecodeHelper extends Mock implements LoginDecodeHelper {}

void main() {
  LoginRepository loginRepository;

  MockLoginDataSource mockLoginDataSource;
  MockLoginDecodeHelper mockDecodeHelper;

  setUp(() {
    mockLoginDataSource = MockLoginDataSource();
    mockDecodeHelper = MockLoginDecodeHelper();

    loginRepository = LoginRepository(
      loginDataSource: mockLoginDataSource,
      loginDecodeHelper: mockDecodeHelper,
    );
  });

  group('Login repository:', () {
    final tTokenLocal = '321321321';

    TokenModel tokenModel = TokenModel();

    final tRetornoSucesso = Success(statusCode: 200);

    test(
      'Sucesso - Deve retornar um TokenModel',
      () async {
        when(mockLoginDataSource.realizarLogin(body: anyNamed('body')))
            .thenAnswer((_) async => tRetornoSucesso);

        when(mockDecodeHelper.decodeLogin(result: tRetornoSucesso))
            .thenAnswer((_) => Right(tokenModel));

        final result = await loginRepository.realizarLogin('any', 'any');

        expect(result, isA<Right>());
        expect(result.fold((l) => l, (r) => r), isA<TokenModel>());
        verify(mockLoginDataSource.realizarLogin(body: anyNamed('body')))
            .called(1);
        verifyNoMoreInteractions(mockLoginDataSource);
      },
    );

    test(
      'Falha - Deve retornar um Failure',
      () async {
        when(mockLoginDataSource.realizarLogin(body: anyNamed('body')))
            .thenAnswer((_) async => tRetornoSucesso);

        when(mockDecodeHelper.decodeLogin(result: tRetornoSucesso))
            .thenAnswer((_) => Left(Failure()));

        final result = await loginRepository.realizarLogin('any', 'any');

        expect(result, isA<Left>());
        expect(result.fold((l) => l, (r) => r), isA<Failure>());
        verify(mockLoginDataSource.realizarLogin(body: anyNamed('body')))
            .called(1);
        verifyNoMoreInteractions(mockLoginDataSource);
      },
    );

    test(
      'Sucesso - Deve retornar um TokenModel Local',
      () async {
        when(mockLoginDataSource.buscarCabecalhoLocal())
            .thenAnswer((_) async => tTokenLocal);

        when(mockDecodeHelper.decodeLogin(result: tRetornoSucesso))
            .thenAnswer((_) => Right(tokenModel));

        final result = await loginRepository.buscarCabecalhosLocal();

        expect(result, isA<TokenModel>());
        verify(mockLoginDataSource.buscarCabecalhoLocal()).called(1);
        verifyNoMoreInteractions(mockLoginDataSource);
      },
    );
  });
}
