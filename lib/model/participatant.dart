
import 'package:json_annotation/json_annotation.dart';

part 'participatant.g.dart';

@JsonSerializable()
class Participant {
  int id;
  String name;
  String phoneNumber;
  Participant({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });
  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}
