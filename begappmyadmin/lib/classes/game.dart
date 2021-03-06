import 'package:begappmyadmin/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Game {
  String id;
  String name;
  String description;
  String creator;
  Map parameters;
  Map defaultParameters;

  Game(
    this.id,
    this.name,
    this.description,
    this.creator,
    this.parameters,
    this.defaultParameters,
  );
  factory Game.fromJson(dynamic json) {
    return Game(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      json['creator'] as String,
      json['parameters'],
      json['defaultParameters'],
    );
  }
  // Map<String, dynamic> toJson() => _$GameToJson(this);
}
