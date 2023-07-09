import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  int? isVerified;

  UserModel({
    this.id,
    this.isVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'isVerified': isVerified,
      };
}
