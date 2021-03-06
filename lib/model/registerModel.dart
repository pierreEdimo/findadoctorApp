import 'package:flutter/foundation.dart';

class RegisterModel {
  final String? userName;
  final String? passWord;
  final String? email;

  RegisterModel({
    @required this.userName,
    @required this.passWord,
    @required this.email,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        userName: json['userName'] as String,
        passWord: json['passWord'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "passWord": passWord,
        "email": email,
      };
}
