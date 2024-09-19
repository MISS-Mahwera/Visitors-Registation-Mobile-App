import 'package:json_annotation/json_annotation.dart';
import 'package:projects/model/participant.dart';
import 'package:hive/hive.dart';

part 'schedule_meeting.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ScheduleMeeting {
  static int _nextId = 1;
  @HiveField(1) final int id;
  @HiveField(2)String name;
  @HiveField(3)String region;
  @HiveField(4)DateTime date;
  @HiveField(5)int days;
  @HiveField(6)List <Participant>? participant;
  ScheduleMeeting({
    required this.name, required this.date,
    required this.region, required this.days, this.participant,
}) : id = _nextId++;
  // A necessary factory constructor for creating a new ScheduleMeeting instance
  // from a map. Pass the map to the generated `_$ScheduleMeetingFromJson()` constructor.
  factory ScheduleMeeting.fromJson(Map<String, dynamic> json) =>
      _$ScheduleMeetingFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleMeetingToJson(this);
}