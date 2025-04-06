import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:story_app/core/endpoint/endpoint.dart';
import 'package:story_app/core/exception/app_exception.dart';
import 'package:story_app/core/model/request/add_new_story_request_model.dart';
import 'package:story_app/core/model/response/add_new_story_response_model.dart';
import 'package:story_app/core/model/response/get_detail_story_response_model.dart';
import 'package:story_app/core/network/http_client.dart';
import 'package:story_app/core/network/network_logger.dart';
import 'package:story_app/core/services/auth/auth_local_service.dart';

import '../../model/response/get_all_stories_response_model.dart';

abstract class StoriesService {
  Future<GetAllStoriesResponseModel> getAllStories(
    int page,
    int size,
    int location,
  );
  Future<GetDetailStoryResponseModel> getDetailStory(String id);
  Future<AddNewStoryResponseModel> addNewStory(AddNewStoryRequestModel data);
}

class StoriesServiceImpl implements StoriesService {
  final Endpoint _endpoint;
  final CoinsleekHttpClient _httpClient;
  final AuthLocalService _authLocalService;

  StoriesServiceImpl({
    required Endpoint endpoint,
    required CoinsleekHttpClient httpClient,
    required AuthLocalService authLocalService,
  }) : _endpoint = endpoint,
       _httpClient = httpClient,
       _authLocalService = authLocalService;

  @override
  Future<GetAllStoriesResponseModel> getAllStories(
    int page,
    int size,
    int location,
  ) async {
    final url = _endpoint.getAllStories(page, size, location);
    final dataLogin = await _authLocalService.getAuthData();
    final token = dataLogin?.token;
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await _httpClient.get(url, headers);
      return GetAllStoriesResponseModel.fromJson(response.body);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  @override
  Future<GetDetailStoryResponseModel> getDetailStory(String id) async {
    final url = _endpoint.getDetailStory(id);
    final dataLogin = await _authLocalService.getAuthData();
    final token = dataLogin?.token;
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await _httpClient.get(url, headers);
      return GetDetailStoryResponseModel.fromJson(response.body);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  @override
  Future<AddNewStoryResponseModel> addNewStory(
    AddNewStoryRequestModel data,
  ) async {
    final url = _endpoint.addNewStory();
    final dataLogin = await _authLocalService.getAuthData();
    final token = dataLogin?.token;
    final headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await _httpClient
          .multipartPost(
            url: url,
            headers: headers,
            files: data.toMap(),
            fields: data.toMapString(),
          )
          .timeout(const Duration(seconds: 30));

      appNetworkLogger(
        endpoint: url.toString(),
        payload: headers.toString(),
        response: response.toString(),
      );

      final Uint8List responseList = await response.stream.toBytes();
      final String responseData = String.fromCharCodes(responseList);

      if (response.statusCode == 201) {
        final data = AddNewStoryResponseModel.fromJson(responseData);
        return data;
      } else {
        final errorResponse = AddNewStoryResponseModel.fromJson(responseData);
        throw AppException(errorResponse.message ?? '').message;
      }
    } on SocketException {
      throw AppException('No Internet connection').message;
    } on TimeoutException {
      throw AppException('Request timeout').message;
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  factory StoriesServiceImpl.create() {
    return StoriesServiceImpl(
      endpoint: Endpoint.baseUrlApi(),
      httpClient: CoinsleekHttpClient.create(),
      authLocalService: AuthLocalServiceImpl.create(),
    );
  }
}
