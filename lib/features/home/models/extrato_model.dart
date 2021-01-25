class ExtratoModel {
  List<Statement> statement;

  ExtratoModel({this.statement});

  ExtratoModel.fromJson(Map<String, dynamic> json) {
    if (json['statement'] != null) {
      statement = new List<Statement>();
      json['statement'].forEach((v) {
        statement.add(new Statement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statement != null) {
      data['statement'] = this.statement.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statement {
  int id;
  String accountName;
  int amount;
  int balance;
  String createdAt;
  String operationType;
  String status;
  OtherInfo otherInfo;

  Statement(
      {this.id,
      this.accountName,
      this.amount,
      this.balance,
      this.createdAt,
      this.operationType,
      this.status,
      this.otherInfo});

  Statement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountName = json['accountName'];
    amount = json['amount'];
    balance = json['balance'];
    createdAt = json['createdAt'];
    operationType = json['operationType'];
    status = json['status'];
    otherInfo = json['otherInfo'] != null
        ? new OtherInfo.fromJson(json['otherInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountName'] = this.accountName;
    data['amount'] = this.amount;
    data['balance'] = this.balance;
    data['createdAt'] = this.createdAt;
    data['operationType'] = this.operationType;
    data['status'] = this.status;
    if (this.otherInfo != null) {
      data['otherInfo'] = this.otherInfo.toJson();
    }
    return data;
  }
}

class OtherInfo {
  String otherAccountName;
  double userLatitude;
  double userLongitude;
  int transactionCategoryId;
  String cupom;

  OtherInfo(
      {this.otherAccountName,
      this.userLatitude,
      this.userLongitude,
      this.transactionCategoryId,
      this.cupom});

  OtherInfo.fromJson(Map<String, dynamic> json) {
    otherAccountName = json['otherAccountName'];
    userLatitude = json['userLatitude'];
    userLongitude = json['userLongitude'];
    transactionCategoryId = json['transactionCategoryId'];
    cupom = json['cupom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otherAccountName'] = this.otherAccountName;
    data['userLatitude'] = this.userLatitude;
    data['userLongitude'] = this.userLongitude;
    data['transactionCategoryId'] = this.transactionCategoryId;
    data['cupom'] = this.cupom;
    return data;
  }
}
