import 'package:ewally/configs/ui/Cores.dart';
import 'package:ewally/configs/ui/DimensoesTela.dart';
import 'package:ewally/configs/ui/Fontes.dart';
import 'package:ewally/configs/ui/Strings.dart';
import 'package:ewally/features/home/models/extrato_model.dart';
import 'package:ewally/configs/utils/DateTimeExtension.dart';
import 'package:ewally/configs/utils/ValorMonetarioExtension.dart';
import 'package:ewally/features/home/screen/widget/chart_widget.dart/chart_widget.dart';
import 'package:ewally/features/home/screen/widget/chart_widget.dart/chart_view_model.dart';
import 'package:flutter/material.dart';

enum TipoExibicao { GRAFICO, LISTA }

abstract class ContentFactory {
  static String formatString(String operation) {
    final primeiraLetra = operation[0].toUpperCase();
    final restante = operation.replaceAll('_', ' ').toLowerCase().substring(1);
    return '$primeiraLetra$restante';
  }

  static String formatStringQuebraLinha(String descricao) {
    final descricaoFormatada = descricao.replaceAll('@', '\n');
    return descricaoFormatada;
  }

  static Widget _noData() {
    return Container(
      child: Text(
        Strings.nenhumaInformacao,
        style: TextStyle(
          fontSize: 16.ssp,
          color: Cores.preto,
          fontFamily: Fontes.montserrat,
        ),
      ),
    );
  }

  static Widget buildContent(
    ExtratoModel extrato,
    TipoExibicao tipoExibicao,
  ) {
    switch (tipoExibicao) {
      case TipoExibicao.GRAFICO:
        return ContentFactory._buildChart(extrato);
      default:
        return ContentFactory._buildListItens(extrato);
    }
  }

  static Widget _buildChart(ExtratoModel extrato) {
    List<ChartData> chartData = [];

    final List<Statement> listStatement = extrato.statement;

    if (listStatement.length == 0) return ContentFactory._noData();

    listStatement.forEach((Statement statement) {
      chartData.add(
        ChartData(
          dayNumber: statement.createdAt.primeiroNumero,
          totalAmount: statement.amount / 100,
        ),
      );
    });

    final chartViewModel = ChartViewModel.createModel(chartData);

    final chart = SimpleBarChart(chartViewModel, animate: false);

    return Container(
      height: 250.h,
      width: 250.w,
      margin: EdgeInsets.only(bottom: 25.h),
      child: chart,
    );
  }

  static Widget _buildListItens(ExtratoModel extrato) {
    if (extrato.statement.length == 0) return ContentFactory._noData();

    final List<Widget> _listaWidgets = List.generate(
      extrato.statement?.length,
      (index) => ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  extrato.statement[index].createdAt.formatarDateTimeEmPtBr,
                  style: TextStyle(
                    fontSize: 12.ssp,
                    color: Cores.preto,
                    fontFamily: Fontes.montserrat,
                  ),
                ),
                Text(
                  ContentFactory.formatString(
                    extrato.statement[index].operationType,
                  ),
                  style: TextStyle(
                      fontSize: 12.ssp,
                      color: Cores.preto,
                      fontFamily: Fontes.montserrat,
                      fontWeight: Fontes.semiBold),
                ),
              ],
            ),
            Text(
              extrato.statement[index].amount.emRealComSinal,
              style: TextStyle(
                fontSize: 12.ssp,
                color: extrato.statement[index].amount < 0
                    ? Cores.vermelhorErro
                    : Cores.preto,
                fontFamily: Fontes.montserrat,
              ),
            )
          ],
        ),
        children: [
          ContentFactory._buildOtherInfo(
            extrato.statement[index].otherInfo,
          ),
        ],
      ),
    );

    return Column(
      children: _listaWidgets,
    );
  }

  static Widget _buildOtherInfo(OtherInfo otherInfo) {
    return Container(
      padding: EdgeInsets.all(12.w),
      width: double.infinity,
      color: Cores.claro,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (otherInfo.userLatitude != null)
            Text(
              'Latitude: ${otherInfo.userLatitude.toString()}',
              style: TextStyle(
                fontSize: 14.ssp,
                color: Cores.preto,
                fontFamily: Fontes.montserrat,
              ),
            ),
          if (otherInfo.userLongitude != null)
            Padding(
              padding: EdgeInsets.only(top: 8.w),
              child: Text(
                'Longitude: ${otherInfo.userLongitude.toString()}',
                style: TextStyle(
                  fontSize: 14.ssp,
                  color: Cores.preto,
                  fontFamily: Fontes.montserrat,
                ),
              ),
            ),
          if (otherInfo.cupom != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 15.w),
              child: Text(
                ContentFactory.formatStringQuebraLinha(otherInfo.cupom),
                style: TextStyle(
                  fontSize: 14.ssp,
                  color: Cores.preto,
                  fontFamily: Fontes.montserrat,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
