import 'package:begappmyadmin/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Participant {
  String id;
  String experimentId;
  String? name;
  String? email;
  String? age;
  String? gender;

  Participant(this.id, this.experimentId,
      {this.name, this.email, this.age, this.gender});
  factory Participant.fromJson(dynamic json) {
    return Participant(
      json['id'] as String,
      json['experimentId'] as String,
    );
  }
  // Map<String, dynamic> toJson() => _$GameToJson(this);
}
