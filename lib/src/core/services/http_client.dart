import 'package:result_dart/result_dart.dart';

abstract interface class CustomHttpClient {
  Future<AsyncResult<T>> get<T extends Object>(
    String url, {
    Map<String, String>? headers,
  });
  Future<AsyncResult<T>> post<T extends Object>(
    String url, {
    Map<String, String>? headers,
    Object? data,
  });
  Future<AsyncResult<T>> put<T extends Object>(
    String url, {
    Map<String, String>? headers,
    Object? data,
  });
  Future<AsyncResult<T>> delete<T extends Object>(
    String url, {
    Map<String, String>? headers,
  });
}
