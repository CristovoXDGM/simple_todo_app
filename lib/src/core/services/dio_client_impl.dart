import 'package:result_dart/src/types.dart';

import 'http_client.dart';

class DioClientImpl implements CustomHttpClient {
  @override
  Future<AsyncResult<T>> delete<T extends Object>(String url,
      {Map<String, String>? headers}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<AsyncResult<T>> get<T extends Object>(String url,
      {Map<String, String>? headers}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<AsyncResult<T>> post<T extends Object>(String url,
      {Map<String, String>? headers, Object? data}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<AsyncResult<T>> put<T extends Object>(String url,
      {Map<String, String>? headers, Object? data}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
