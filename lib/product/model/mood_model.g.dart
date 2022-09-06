// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodModel _$MoodModelFromJson(Map<String, dynamic> json) => MoodModel(
      moodImgPath: json['moodImgPath'] as String,
      hour: json['hour'] as String,
      activity: json['activity'] as String,
      peoplesWith: (json['peoplesWith'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MoodModelToJson(MoodModel instance) => <String, dynamic>{
      'moodImgPath': instance.moodImgPath,
      'hour': instance.hour,
      'activity': instance.activity,
      'peoplesWith': instance.peoplesWith,
    };
