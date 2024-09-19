
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participant.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Participant {
  static int _nextId = 1;
  @HiveField(0) final int id;
  @HiveField(1) String name;
  @HiveField(2) String phoneNumber;
  Participant({
    required this.name,
    required this.phoneNumber,
  }): id = _nextId++;
  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}
