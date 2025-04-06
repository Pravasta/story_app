import 'package:story_app/core/exception/app_exception.dart';

import '../model/response/meta_response.dart';

class MetaExceptionHandler {
  final int statusCode;
  final dynamic responseBody;

  MetaExceptionHandler(this.statusCode, this.responseBody);

  void handleByErrorCode() {
    String message =
        MetaResponse.fromJson(responseBody).message ?? "Unknown Error";

    switch (statusCode) {
      case 400:
        throw AppException(message).message;
      case 401:
        throw AppException(message).message;
      default:
        throw AppException(message).message;
    }
  }
}
