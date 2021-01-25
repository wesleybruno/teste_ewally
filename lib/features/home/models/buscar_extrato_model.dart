class BuscarExtratoModel {
  String initialDate;
  String finalDate;

  BuscarExtratoModel({this.initialDate, this.finalDate});

  String _formatarData(String data) {
    if (data != null) {
      final dataArray = data.split('-');

      final dataFormatada =
          '${dataArray.last}-${dataArray[1]}-${dataArray.first}';

      return dataFormatada;
    }

    return '';
  }

  BuscarExtratoModel.fromDataString(
    String dataInicial,
    String dataFinal,
  ) {
    initialDate = _formatarData(dataInicial);
    finalDate = _formatarData(dataFinal);
  }

  BuscarExtratoModel.fromJson(Map<String, dynamic> json) {
    initialDate = json['initialDate'];
    finalDate = json['finalDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['initialDate'] = this.initialDate;
    data['finalDate'] = this.finalDate;
    return data;
  }
}
