import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class UserModel {
  int id;
  String firstName;
  String lastName;
  String picture;

  UserModel({this.id, this.firstName = '', this.lastName = '', this.picture});

  static final UserModel zero = UserModel(
      id: 0,
      firstName: 'May',
      lastName: 'Hampton',
    );

  factory UserModel.fromJson(Map user) => _$UserModelFromJson(user);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
