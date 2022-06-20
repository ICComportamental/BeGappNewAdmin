import 'package:begappmyadmin/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  String name;
  String description;
  String creator;
  Map parameters;
  Map defaultParameters;

  Game(
    this.name,
    this.description,
    this.creator,
    this.parameters,
    this.defaultParameters,
  );

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
