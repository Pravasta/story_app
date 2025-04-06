import 'dart:convert';

class GetDetailStoryResponseModel {
  final bool? error;
  final String? message;
  final Story? story;

  GetDetailStoryResponseModel({this.error, this.message, this.story});

  factory GetDetailStoryResponseModel.fromJson(String str) =>
      GetDetailStoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDetailStoryResponseModel.fromMap(Map<String, dynamic> json) =>
      GetDetailStoryResponseModel(
        error: json["error"],
        message: json["message"],
        story: json["story"] == null ? null : Story.fromMap(json["story"]),
      );

  Map<String, dynamic> toMap() => {
    "error": error,
    "message": message,
    "story": story?.toMap(),
  };
}

class Story {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final DateTime? createdAt;
  final double? lat;
  final double? lon;

  Story({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  factory Story.fromJson(String str) => Story.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Story.fromMap(Map<String, dynamic> json) => Story(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    photoUrl: json["photoUrl"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "photoUrl": photoUrl,
    "createdAt": createdAt?.toIso8601String(),
    "lat": lat,
    "lon": lon,
  };
}
