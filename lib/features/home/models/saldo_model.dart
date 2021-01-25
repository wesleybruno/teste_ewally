class SaldoModel {
  int balance;
  int blockedBalance;

  SaldoModel({this.balance, this.blockedBalance});

  SaldoModel.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    blockedBalance = json['blockedBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['blockedBalance'] = this.blockedBalance;
    return data;
  }
}
