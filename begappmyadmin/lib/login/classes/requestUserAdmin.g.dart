// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestUserAdmin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUser _$AdminUserFromJson(Map<String, dynamic> json) => AdminUser(
      json['name'] as String,
      json['username'] as String,
      json['email'] as String,
      json['password'] as String,
      json['confirmPassword'] as String,
    );

Map<String, dynamic> _$AdminUserToJson(AdminUser instance) => <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
