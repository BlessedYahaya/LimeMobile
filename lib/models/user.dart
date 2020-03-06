import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class UserModel {
  int id;
  String firstName;
  String lastName;

  UserModel({this.id, this.firstName = '', this.lastName = ''});

  static final UserModel zero = UserModel();

  factory UserModel.fromJson(Map user) => _$UserModelFromJson(user);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
