import 'package:begappmyadmin/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'requestUserAdmin.g.dart';

@JsonSerializable()
class AdminUser {
  ///@JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  String name;
  String username;
  String email;
  String password;
  String confirmPassword;
  // @JsonKey(
  //     fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  // bool approved;

  AdminUser(this.name, this.username, this.email, this.password,
      this.confirmPassword);

  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);
  Map<String, dynamic> toJson() => _$AdminUserToJson(this);

  // static int MyConverter.stringToInt(String number) =>
  //     number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();

  // static bool MyConverter.stringToBool(String b) => b == null ? null : parseBool(b);
  // static String MyConverter.stringFromBool(bool b) => b?.toString();

  // static bool parseBool(String b) {
  //   return b.toLowerCase() == '1';
  // }
}
