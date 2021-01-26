import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class ChartData {
  String dayNumber;
  double totalAmount;

  ChartData({
    @required this.dayNumber,
    @required this.totalAmount,
  });
}

abstract class ChartViewModel {
  static List<charts.Series<ChartData, String>> createModel(
      List<ChartData> lista) {
    return [
      charts.Series<ChartData, String>(
        id: 'Sales',
        colorFn: (chartData, __) => chartData.totalAmount > 0
            ? charts.MaterialPalette.blue.shadeDefault
            : charts.MaterialPalette.red.shadeDefault,
        domainFn: (ChartData chartData, _) => chartData.dayNumber,
        measureFn: (ChartData chartData, _) => chartData.totalAmount,
        data: lista,
      )
    ];
  }
}
