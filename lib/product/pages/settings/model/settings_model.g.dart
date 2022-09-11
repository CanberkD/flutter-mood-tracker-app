// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      wakeUpHour: json['wakeUpHour'] as int,
      wakeUpMinute: json['wakeUpMinute'] as int,
      sleepHour: json['sleepHour'] as int,
      sleepMinute: json['sleepMinute'] as int,
      isNotificationOn: json['isNotificationOn'] as bool,
      notificationCountInADay: json['notificationCountInADay'] as int,
      language: json['language'] as String,
      isThemeLight: json['isThemeLight'] as bool,
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'wakeUpHour': instance.wakeUpHour,
      'wakeUpMinute': instance.wakeUpMinute,
      'sleepHour': instance.sleepHour,
      'sleepMinute': instance.sleepMinute,
      'isNotificationOn': instance.isNotificationOn,
      'notificationCountInADay': instance.notificationCountInADay,
      'language': instance.language,
      'isThemeLight': instance.isThemeLight,
    };
