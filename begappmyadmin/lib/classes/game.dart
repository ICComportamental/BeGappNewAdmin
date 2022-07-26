import 'dart:convert';

import 'package:begappmyadmin/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Game {
  String id;
  String name;
  String description;
  String creator;
  bool participant;
  Map parameters;
  Map defaultParameters;
  Map resultsFormat;

  Game(
    this.id,
    this.name,
    this.description,
    this.creator,
    this.participant,
    this.parameters,
    this.defaultParameters,
    this.resultsFormat,
  );
  factory Game.fromJson(dynamic json) {
    return Game(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      json['creator'] as String,
      json['participant'] as bool,
      json['parameters'],
      json['defaultParameters'],
      json['resultsFormat'],
    );
  }
  // Map<String, dynamic> toJson() => _$GameToJson(this);
}
