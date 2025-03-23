import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '_apis_service.dart';

class DioService {
  // Dio instance
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // Constructor to add interceptors
  DioService() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
      ),
    );
  }

  // Optional cancel token for request cancellation
  CancelToken? cancelToken;

  /// Cancel any ongoing requests
  void cancelOngoingRequests() {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken?.cancel('Request canceled.');
    }
    cancelToken = CancelToken();
  }

  /// General HTTP Request Handler
  Future<T?> request<T>({
    required String path,
    required String method,
    Map<String, dynamic>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
  }) async {
    try {
      // Make HTTP request
      final response = await dio.request(
        path,
        options: Options(method: method, headers: headers),
        queryParameters: queryParameters,
        data: data,
        cancelToken: token ?? cancelToken,
      );

      // Parse response using the provided parser
      if (parser != null) {
        return parser(response.data);
      } else {
        return response.data as T;
      }
    } on DioException catch (e) {
      log('DioException: ${e.message}');
      if (CancelToken.isCancel(e)) {
        log('Request canceled');
        throw Exception('Request canceled: $e');
      } else {
        handleError(e);
        throw Exception(e);
      }
    } catch (e) {
      log('Unhandled error: $e');
      throw Exception(e);
    }
  }

  /// GET Method
  Future<T?> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
  }) async {
    return request(
      path: path,
      method: 'GET',
      queryParameters: queryParameters,
      headers: headers,
      token: token,
      parser: parser,
    );
  }

  /// POST Method
  Future<T?> post<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
  }) async {
    return request(
      path: path,
      method: 'POST',
      data: data,
      headers: headers,
      token: token,
      parser: parser,
    );
  }

  /// PUT Method
  Future<T?> put<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
  }) async {
    return request(
      path: path,
      method: 'PUT',
      data: data,
      headers: headers,
      token: token,
      parser: parser,
    );
  }

  /// DELETE Method
  Future<T?> delete<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
  }) async {
    return request(
      path: path,
      method: 'DELETE',
      data: data,
      headers: headers,
      token: token,
      parser: parser,
    );
  }

  /// Handle Errors Globally
  void handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        log('Connection timeout: ${error.message}');
        throw Exception('Connection timeout: ${error.message}');
      case DioExceptionType.receiveTimeout:
        log('Receive timeout: ${error.message}');
        throw Exception('Receive timeout: ${error.message}');
      case DioExceptionType.badResponse:
        log('Bad response: ${error.response?.statusCode} ${error.response?.data}');
        throw Exception(error.response?.data['message']);
      default:
        log('Unexpected error: ${error.message}');
        throw Exception('Unexpected error: ${error.message}');
    }
  }
}
