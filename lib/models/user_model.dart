import 'package:book_store_manager/utils/converter.dart';

class UserModel {
  final String userId;
  final String name;
  final String avatar;
  final bool isMale;
  final String birthday;
  final String phoneNumber;

  UserModel({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.isMale,
    required this.birthday,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      userId: id,
      name: cvToString(json['name']),
      avatar: cvToString(json['avatar']),
      isMale: cvToBool(json['isMale']),
      birthday: cvToString(json['birthday']),
      phoneNumber: cvToString(json['phoneNumber']),
    );
  }
}

class UserLiteModel {
  final String id;
  final String name;
  final String avatar;

  UserLiteModel({required this.id, required this.name, required this.avatar});

  factory UserLiteModel.fromJson(String id, Map<String, dynamic> json) {
    return UserLiteModel(
      id: id,
      name: cvToString(json['name']),
      avatar: cvToString(json['avatar']),
    );
  }
}
