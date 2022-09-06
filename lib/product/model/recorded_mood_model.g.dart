// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recorded_mood_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordedMoodModel _$RecordedMoodModelFromJson(Map<String, dynamic> json) =>
    RecordedMoodModel(
      moodList: (json['moodList'] as List<dynamic>)
          .map((e) => MoodModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: MoodDateModel.fromJson(json['date'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecordedMoodModelToJson(RecordedMoodModel instance) =>
    <String, dynamic>{
      'moodList': instance.moodList.map((e) => e.toJson()).toList(),
      'date': instance.date.toJson(),
    };

MoodDateModel _$MoodDateModelFromJson(Map<String, dynamic> json) =>
    MoodDateModel(
      day: json['day'] as int,
      month: json['month'] as int,
      year: json['year'] as int,
    );

Map<String, dynamic> _$MoodDateModelToJson(MoodDateModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
    };
