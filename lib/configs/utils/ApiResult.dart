abstract class ApiResult {
  String message;
  int statusCode;

  Map<String, dynamic> data;
}

class Success implements ApiResult {
  int statusCode;
  Map<String, dynamic> data;
  Map<String, dynamic> responseHeaders;
  List dataList;
  String message;
  Success({this.statusCode, this.data, this.dataList, this.responseHeaders});
}

class Failure implements ApiResult {
  int statusCode;
  String message;
  Map<String, dynamic> data;

  Failure({
    this.statusCode,
    this.message,
    this.data,
  });
}

class ApiError implements ApiResult {
  int statusCode;
  String message;
  Map<String, dynamic> data;

  ApiError({
    this.statusCode,
    this.message,
    this.data,
  });
}

class NoInternet implements ApiResult {
  int statusCode;
  String message;
  Map<String, dynamic> data;

  NoInternet({
    this.statusCode,
    this.message,
    this.data,
  });
}
