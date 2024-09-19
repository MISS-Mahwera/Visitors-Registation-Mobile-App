// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_meeting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleMeetingAdapter extends TypeAdapter<ScheduleMeeting> {
  @override
  final int typeId = 0;

  @override
  ScheduleMeeting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleMeeting(
      name: fields[2] as String,
      date: fields[4] as DateTime,
      region: fields[3] as String,
      days: fields[5] as int,
      participant: (fields[6] as List?)?.cast<Participant>(),
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleMeeting obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.region)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.days)
      ..writeByte(6)
      ..write(obj.participant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleMeetingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleMeeting _$ScheduleMeetingFromJson(Map<String, dynamic> json) =>
    ScheduleMeeting(
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      region: json['region'] as String,
      days: (json['days'] as num).toInt(),
      participant: (json['participant'] as List<dynamic>?)
          ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleMeetingToJson(ScheduleMeeting instance) =>
    <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'date': instance.date.toIso8601String(),
      'days': instance.days,
      'participant': instance.participant,
    };
