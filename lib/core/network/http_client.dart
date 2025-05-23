import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/core/exception/met_exception_handler.dart';
import 'package:story_app/core/model/response/meta_response.dart';
import 'package:story_app/core/network/network_logger.dart';

abstract class HttpClient<T> {
  Future<T> get(Uri url, Map<String, String>? headers);
  Future<T> post(Uri url, Map<String, String>? headers, Object? body);
  Future<T> put(Uri url, Map<String, String>? headers, Object? body);
  Future<T> patch(Uri url, Map<String, String>? headers, Object? body);
  Future<T> delete(Uri url, Map<String, String>? headers, Object? body);
  Future<T> multipartPost({
    required Uri url,
    required Map<String, String> headers,
    required Map<String, File> files,
    Map<String, String>? fields,
  });
  Future<T> multipartPut({
    required Uri url,
    required Map<String, String> headers,
    required Map<String, File> files,
    Map<String, String>? fields,
  });
  Future<Uint8List> getBytesArrayFromUrl(String url);
  Future<String> downloadAndSaveFile(String url, String fileName);
}

class CoinsleekHttpClient implements HttpClient {
  final http.Client _client;

  CoinsleekHttpClient(this._client);

  @override
  Future<http.Response> delete(
    Uri url,
    Map<String, String>? headers,
    Object? body,
  ) async {
    try {
      final response = await _client.delete(url, headers: headers, body: body);

      appNetworkLogger(
        endpoint: url.toString(),
        payload: headers.toString(),
        response: response.toString(),
      );

      return response;
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<http.Response> get(Uri url, Map<String, String>? headers) async {
    try {
      final response = await _client
          .get(url, headers: headers)
          .timeout(Duration(seconds: 10));

      appNetworkLogger(
        endpoint: url.toString(),
        payload: headers.toString(),
        response: response.toString(),
      );

      MetaResponse metaResponse = MetaResponse.fromJson(
        jsonDecode(response.body),
      );

      if (metaResponse.error != false && response.statusCode != 200) {
        MetaExceptionHandler(
          response.statusCode,
          jsonDecode(response.body),
        ).handleByErrorCode();
      }

      return response;
    } on SocketException {
      throw Exception('No Internet connection');
    } on TimeoutException {
      throw Exception('Request timeout');
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<http.Response> post(
    Uri url,
    Map<String, String>? headers,
    Object? body,
  ) async {
    try {
      final response = await _client
          .post(url, headers: headers, body: body)
          .timeout(Duration(seconds: 10));

      appNetworkLogger(
        endpoint: url.toString(),
        payload: headers.toString(),
        response: response.body.toString(),
      );

      MetaResponse metaResponse = MetaResponse.fromJson(
        jsonDecode(response.body),
      );

      if (metaResponse.error != false) {
        MetaExceptionHandler(
          response.statusCode,
          jsonDecode(response.body),
        ).handleByErrorCode();
      }

      return response;
    } on SocketException {
      throw Exception('No Internet connection');
    } on TimeoutException {
      throw Exception('Request Timeout');
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<http.Response> put(
    Uri url,
    Map<String, String>? headers,
    Object? body,
  ) async {
    try {
      final response = await _client.put(url, headers: headers, body: body);

      appNetworkLogger(
        endpoint: url.toString(),
        payload: headers.toString(),
        response: response.toString(),
      );

      return response;
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<http.Response> patch(
    Uri url,
    Map<String, String>? headers,
    Object? body,
  ) async {
    try {
      final response = await _client.patch(url, headers: headers, body: body);

      appNetworkLogger(
        endpoint: url.toString(),
        payload: headers.toString(),
        response: response.toString(),
      );

      return response;
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<http.StreamedResponse> multipartPost({
    required Uri url,
    required Map<String, String> headers,
    required Map<String, File> files,
    Map<String, String>? fields,
  }) async {
    http.MultipartRequest request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);
    if (fields != null) request.fields.addAll(fields);

    files.forEach((key, value) {
      request.files.add(
        http.MultipartFile.fromBytes(
          key,
          value.readAsBytesSync(),
          filename: value.path.split('/').last,
        ),
      );
    });
    return request.send();
  }

  @override
  Future<http.StreamedResponse> multipartPut({
    required Uri url,
    required Map<String, String> headers,
    required Map<String, File> files,
    Map<String, String>? fields,
  }) async {
    http.MultipartRequest request = http.MultipartRequest('PUT', url);
    request.headers.addAll(headers);
    if (fields != null) request.fields.addAll(fields);
    files.forEach((key, value) {
      request.files.add(
        http.MultipartFile.fromBytes(
          key,
          value.readAsBytesSync(),
          filename: value.path.split('/').last,
        ),
      );
    });
    return request.send();
  }

  @override
  Future<Uint8List> getBytesArrayFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  @override
  Future<String> downloadAndSaveFile(String url, String fileName) async {
    final bytes = await getBytesArrayFromUrl(url);
    return base64Encode(bytes);
  }

  factory CoinsleekHttpClient.create() {
    final client = http.Client();
    return CoinsleekHttpClient(client);
  }
}
