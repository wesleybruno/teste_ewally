class DadosInvalidosModel {
  int code;
  String msg;

  DadosInvalidosModel({this.code, this.msg});

  DadosInvalidosModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}
