import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ewally/configs/client/check_connectivty.dart';
import 'package:ewally/configs/client/custom_dio.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/configs/utils/Endpoint.dart';
import 'package:ewally/injection_container.dart';

class RequestApiProvider {
  CustomDio _customDio;

  RequestApiProvider({
    @required CustomDio customDio,
  }) : _customDio = customDio;

  Future<ApiResult> execute(Endpoint endpoint) async {
    try {
      final possuiInternet =
          await dependencia<LocalConnectivity>().checkConnection();
      if (!possuiInternet) return NoInternet();

      Response response;
      switch (endpoint.method) {
        case EndPointMethod.get:
          response = await getAsync(endpoint.finalUrl());
          break;
        case EndPointMethod.post:
          response = await post(endpoint.url, endpoint.data);
          break;
        case EndPointMethod.delete:
          response = await delete(endpoint.data, endpoint.data);
          break;
        case EndPointMethod.put:
          response = await put(endpoint.data, endpoint.data);
          break;
        case EndPointMethod.patch:
          response = await patch(endpoint.url, endpoint.data);
          break;
        default:
          return Failure(
            statusCode: null,
            message: 'Method Invalid',
          );
      }

      if (response.data != null && response.statusCode < 300) {
        final Map<String, dynamic> responseHeaders = {
          "uid": response?.headers?.value('uid'),
          "client": response?.headers?.value("client"),
          "access-token": response?.headers?.value("access-token"),
        };
        return response.data is List
            ? Success(
                dataList: response.data,
                statusCode: response.statusCode,
                responseHeaders: responseHeaders,
              )
            : Success(
                data: response.data is Map ? response.data : {"resp": true},
                statusCode: response.statusCode,
                responseHeaders: responseHeaders,
              );
      }

      return Failure(
        statusCode: response.statusCode,
        message: response.statusMessage,
        data: response.data,
      );
    } catch (e) {
      return ApiError(
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
      );
    }
  }

  Future<Response> post(
    String url,
    dynamic objeto,
  ) async {
    return await _customDio.client.post(url, data: objeto);
  }

  Future<Response> put(
    String url,
    dynamic objeto,
  ) async {
    return await _customDio.client.put(url, data: objeto);
  }

  Future<Response> delete(
    String url,
    dynamic objeto,
  ) async {
    return await _customDio.client.delete(url, data: objeto);
  }

  Future<Response> patch(
    String url,
    dynamic objeto,
  ) async {
    return await _customDio.client.patch(url, data: objeto);
  }

  Future<Response> getAsync(
    String url,
  ) async {
    return await _customDio.client.get(url);
  }
}
