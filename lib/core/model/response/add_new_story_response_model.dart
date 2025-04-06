import 'dart:convert';

class AddNewStoryResponseModel {
  final bool? error;
  final String? message;

  AddNewStoryResponseModel({this.error, this.message});

  factory AddNewStoryResponseModel.fromJson(String str) =>
      AddNewStoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddNewStoryResponseModel.fromMap(Map<String, dynamic> json) =>
      AddNewStoryResponseModel(error: json["error"], message: json["message"]);

  Map<String, dynamic> toMap() => {"error": error, "message": message};
}
