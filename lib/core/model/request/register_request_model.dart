import 'dart:convert';

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory RegisterRequestModel.fromJson(String str) =>
      RegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) {
    return RegisterRequestModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'password': password};
  }
}
