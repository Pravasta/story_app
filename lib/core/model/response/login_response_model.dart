import 'dart:convert';

class LoginResponseModel {
  final bool error;
  final String message;
  final LoginResult loginResult;

  LoginResponseModel({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginResponseModel.fromJson(String str) =>
      LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        error: json["error"],
        message: json["message"],
        loginResult: LoginResult.fromMap(json["loginResult"]),
      );

  Map<String, dynamic> toMap() => {
    "error": error,
    "message": message,
    "loginResult": loginResult.toMap(),
  };
}

class LoginResult {
  final String userId;
  final String name;
  final String token;

  LoginResult({required this.userId, required this.name, required this.token});

  factory LoginResult.fromJson(String str) =>
      LoginResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResult.fromMap(Map<String, dynamic> json) => LoginResult(
    userId: json["userId"],
    name: json["name"],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "name": name,
    "token": token,
  };
}
