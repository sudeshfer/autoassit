import 'dart:convert';

class UserModel {
  String id;
  String userName;
  String garageName;
  String garageId;
  String userType;
  String token;
  String loginStatus;

  UserModel({
      this.id,
      this.userName,
      this.garageName,
      this.garageId,
      this.userType,
      this.token,
      this.loginStatus
  });

  UserModel.fromJson(Map<String, dynamic> map)
      : id = map['_id'],
        userName = map['username'],
        garageName = map['garageName'],
        garageId = map['garageId'],
        userType = map['usertype'],
        token = map['token'],
        loginStatus = map['loginstatus'];
}
