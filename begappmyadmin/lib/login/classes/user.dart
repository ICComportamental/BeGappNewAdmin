import 'package:begappmyadmin/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;
  String username;
  String email;
  String type;
  String passwordRecoveryCode;
  String password;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  bool isActive;

  User(
    this.name,
    this.username,
    this.email,
    this.type,
    this.passwordRecoveryCode,
    this.password,
    this.isActive,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
