import 'package:story_app/core/injection/injection.dart';

import '../network/url_builder.dart';

class Endpoint {
  final String baseURL;

  Endpoint({required this.baseURL});

  Uri register() {
    return UriHelper.createUrl(
      host: baseURL,
      path: "v1/register",
      queryParameters: {},
    );
  }

  Uri login() {
    return UriHelper.createUrl(
      host: baseURL,
      path: "v1/login",
      queryParameters: {},
    );
  }

  Uri getAllStories(int page, int size, int location) {
    return UriHelper.createUrl(
      host: baseURL,
      path: "v1/stories",
      queryParameters: {
        "page": page.toString(),
        "size": size.toString(),
        "location": location.toString(),
      },
    );
  }

  Uri getDetailStory(String id) {
    return UriHelper.createUrl(
      host: baseURL,
      path: "v1/stories/$id",
      queryParameters: {},
    );
  }

  Uri addNewStory() {
    return UriHelper.createUrl(
      host: baseURL,
      path: "v1/stories",
      queryParameters: {},
    );
  }

  factory Endpoint.baseUrlApi() {
    return Endpoint(baseURL: Injection.baseURL);
  }
}
