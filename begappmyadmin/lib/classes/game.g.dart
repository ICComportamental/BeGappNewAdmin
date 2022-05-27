// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['name'] as String,
      json['description'] as String,
      json['creator'] as String,
      Map<String, String>.from(json['parameters'] as Map),
      Map<String, String>.from(json['defaultParameters'] as Map),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'creator': instance.creator,
      'parameters': instance.parameters,
      'defaultParameters': instance.defaultParameters,
    };
