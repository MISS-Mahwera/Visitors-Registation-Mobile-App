import '../login/meeting.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_meeting.g.dart';

@JsonSerializable()
class ScheduleMeeting {
  int id;
  String name;
  DateTime date;
  List <Participant>? participant;
  ScheduleMeeting({
    required this.id, required this.name, required this.date,
});
  // A necessary factory constructor for creating a new ScheduleMeeting instance
  // from a map. Pass the map to the generated `_$ScheduleMeetingFromJson()` constructor.
  factory ScheduleMeeting.fromJson(Map<String, dynamic> json) =>
      _$ScheduleMeetingFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleMeetingToJson(this);
}