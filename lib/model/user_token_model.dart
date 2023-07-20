// To parse this JSON data, do
//
//     final userTokenModel = userTokenModelFromJson(jsonString);

import 'dart:convert';

UserTokenModel userTokenModelFromJson(String str) =>
    UserTokenModel.fromJson(json.decode(str));

String userTokenModelToJson(UserTokenModel data) => json.encode(data.toJson());

class UserTokenModel {
  String token;
  String tokenType;
  int expiresIn;

  UserTokenModel({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
  });

  factory UserTokenModel.fromJson(Map<String, dynamic> json) => UserTokenModel(
        token: json["token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
