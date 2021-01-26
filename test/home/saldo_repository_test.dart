import 'package:dartz/dartz.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/features/home/datasource/saldo_datasource.dart';
import 'package:ewally/features/home/models/extrato_model.dart';
import 'package:ewally/features/home/models/saldo_model.dart';
import 'package:ewally/features/home/repository/extrato_decode_helper.dart';
import 'package:ewally/features/home/repository/saldo_decode_helper.dart';
import 'package:ewally/features/home/repository/saldo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSaldoDataSource extends Mock implements ISaldoDataSource {}

class MockExtratoDecodeHelper extends Mock implements ExtratoDecodeHelper {}

class MockSaldoDecodeHelper extends Mock implements SaldoDecodeHelper {}

void main() {
  SaldoRepository saldoRepository;

  MockSaldoDataSource mockSaldoDataSource;
  MockExtratoDecodeHelper mockExtratoDecodeHelper;
  MockSaldoDecodeHelper mockSaldoDecodeHelper;

  setUp(() {
    mockSaldoDataSource = MockSaldoDataSource();
    mockExtratoDecodeHelper = MockExtratoDecodeHelper();
    mockSaldoDecodeHelper = MockSaldoDecodeHelper();

    saldoRepository = SaldoRepository(
      extratoDecodeHelper: mockExtratoDecodeHelper,
      saldoDataSource: mockSaldoDataSource,
      saldoDecodeHelper: mockSaldoDecodeHelper,
    );
  });

  group('Saldo repository:', () {
    final tDataInicio = '2020-01-01';
    final tDataFim = '2020-01-31';

    ExtratoModel extratoModel = ExtratoModel();
    SaldoModel saldoModel = SaldoModel();

    final tRetornoSucesso = Success(statusCode: 200);

    test(
      'Sucesso - Deve retornar um ExtratoModel',
      () async {
        when(mockSaldoDataSource.buscarExtrato(map: anyNamed('map')))
            .thenAnswer((_) async => tRetornoSucesso);

        when(mockExtratoDecodeHelper.decodeExtrato(result: tRetornoSucesso))
            .thenAnswer((_) => Right(extratoModel));

        final result =
            await saldoRepository.buscarExtrato(tDataInicio, tDataFim);

        expect(result, isA<Right>());
        expect(result.fold((l) => l, (r) => r), isA<ExtratoModel>());
        verify(mockSaldoDataSource.buscarExtrato(map: anyNamed('map')))
            .called(1);
        verifyNoMoreInteractions(mockSaldoDataSource);
      },
    );

    test(
      'Sucesso - Deve retornar um SaldoModel',
      () async {
        when(mockSaldoDataSource.buscarSaldo())
            .thenAnswer((_) async => tRetornoSucesso);

        when(mockSaldoDecodeHelper.decodeSaldo(result: tRetornoSucesso))
            .thenAnswer((_) => Right(saldoModel));

        final result = await saldoRepository.buscarSaldo();

        expect(result, isA<Right>());
        expect(result.fold((l) => l, (r) => r), isA<SaldoModel>());
        verify(mockSaldoDataSource.buscarSaldo()).called(1);
        verifyNoMoreInteractions(mockSaldoDataSource);
      },
    );
  });
}
