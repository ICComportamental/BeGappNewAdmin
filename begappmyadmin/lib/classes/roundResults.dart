import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RoundResults {
  String id;
  String gameId;
  String experimentId;
  String participantId;
  Map result;

  RoundResults(
    this.id,
    this.gameId,
    this.experimentId,
    this.participantId,
    this.result,
  );
  factory RoundResults.fromJson(dynamic json) {
    return RoundResults(
      json['id'] as String,
      json['gameId'] as String,
      json['experimentId'] as String,
      json['participantId'] as String,
      json['result'],
    );
  }
  // Map<String, dynamic> toJson() => _$GameToJson(this);
}
