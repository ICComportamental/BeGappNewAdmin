import 'package:begappmyadmin/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Experiment {
  String id;
  String gameId;
  String description;
  String creator;
  Map parameters;
  bool isConfigsPublic;
  bool isResultsPublic;

  Experiment(
    this.id,
    this.gameId,
    this.description,
    this.creator,
    this.parameters,
    this.isConfigsPublic,
    this.isResultsPublic,
  );
  factory Experiment.fromJson(dynamic json) {
    return Experiment(
      json['id'] as String,
      json['gameId'] as String,
      json['description'] as String,
      json['creator'] as String,
      json['parameters'],
      json['isConfigsPublic'] as bool,
      json['isResultsPublic'] as bool,
    );
  }
  // Map<String, dynamic> toJson() => _$GameToJson(this);
}
