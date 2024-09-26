import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participant.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Participant {
  static int _nextId = 1;

  @HiveField(0)
  final int id; // Unique ID for each participant

  @HiveField(1)
  String name;

  @HiveField(2)
  String phoneNumber;

  @HiveField(3)
  String fingerprint; // Added fingerprint field

  Participant({
    required this.name,
    required this.phoneNumber,
    this.fingerprint = '', // Initialize fingerprint with empty value
  }) : id = _nextId++; // Increment _nextId for each participant instance

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}
