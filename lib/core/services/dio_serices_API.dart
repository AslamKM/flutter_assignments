// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:dio/dio.dart';

import 'package:flutter_assignment/core/config/base_api_configs.dart';

import '../error/http_exception.dart';

class DioAPIServices extends BaseAPIConfig {
  @override
  Future<Map?> getAPI({String authorization = '', String url = ''}) async {
    try {
      if (!await ConnectivityWrapper.instance.isConnected)
        throw HttpException('No Connection', 101);
      Dio _dio = Dio();

      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers['Accept'] = 'application/json';

      if (authorization != null)
        _dio.options.headers['authorization'] = 'Bearer $authorization';

      Response _response =
          await _dio.request(url, options: Options(method: "GET"));

      if (_response.statusCode! < 200 && _response.statusCode! > 226)
        throw HttpException('', _response.statusCode!);

      if (_response.data is String) return null;

      if (_response.data.containsKey('errors'))
        throw HttpException(_response.data['errors'][0], _response.statusCode!);

      return _response.data;
    } catch (e) {
      rethrow;
    }
  }
}
