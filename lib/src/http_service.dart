import 'package:core_service/src/utils/logger.dart';
import 'package:dio/dio.dart';

class HttpService {
  Dio? dio;

  HttpService({required BaseOptions options}) {
    dio = Dio(options);
  }

  Logger _logger = Logger("HttpService");

  Future<Response> get(
    String path,
    Map<String, dynamic> queryParameters,
    Options options,
  ) {
    this._logger.debug("Get: $path");
    return dio!.get(path);
  }

  Future<Response> post(
    String path,
    Map<String, dynamic> queryParameters,
    Options options,
    String data,
  ) {
    this._logger.debug("Post: $path");
    return dio!.post(path);
  }

  Future<Response> put(
    String path,
    Map<String, dynamic> queryParameters,
    Options options,
    String data,
  ) {
    this._logger.debug("Put: $path");
    return dio!.post(path);
  }

  Future<Response> delete(String path) {
    this._logger.debug("Delete:  $path");
    return dio!.delete(path);
  }

  _printProgress(int total, int send) {
    this._logger.debug("Total $total->$send");
  }
}
