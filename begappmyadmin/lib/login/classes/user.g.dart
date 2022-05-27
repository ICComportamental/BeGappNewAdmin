// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['name'] as String,
      json['username'] as String,
      json['email'] as String,
      json['type'] as String,
      json['passwordRecoveryCode'] as String,
      json['password'] as String,
      MyConverter.stringToBool(json['isActive'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'type': instance.type,
      'passwordRecoveryCode': instance.passwordRecoveryCode,
      'password': instance.password,
      'isActive': MyConverter.stringFromBool(instance.isActive),
    };
