import 'package:flutter/foundation.dart';

class LoginModel {
  final String? email;
  final String? password;

  LoginModel({
    @required this.email,
    @required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json['email'] as String,
        password: json['password'] as String,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
