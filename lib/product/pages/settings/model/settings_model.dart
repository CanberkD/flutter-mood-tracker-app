
import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  late int wakeUpHour;
  late int wakeUpMinute;
  late int sleepHour;
  late int sleepMinute;
  late bool isNotificationOn;
  late int notificationCountInADay;
  late String language;
  late bool isThemeLight;

  set setWakeUpHour( wakeUpHour) => this.wakeUpHour = wakeUpHour;
  set setWakeUpMinute(int wakeUpMinute) => this.wakeUpMinute = wakeUpMinute;
  set setSleepHour(int sleepHour) => this.sleepHour = sleepHour;
  set setSleepMinute(int sleepMinute) => this.sleepMinute = sleepMinute;
  set setIsNotificationOn(bool isNotificationOn) => this.isNotificationOn = isNotificationOn;
  set setNotificationCountInADay(int notificationCountInADay) => this.notificationCountInADay = notificationCountInADay;
  set setLanguage(String language) => this.language = language;
  set setIsThemeLight(bool isThemeLight) => this.isThemeLight = isThemeLight;

  SettingsModel({
    required this.wakeUpHour,
    required this.wakeUpMinute,
    required this.sleepHour,
    required this.sleepMinute,
    required this.isNotificationOn,
    required this.notificationCountInADay,
    required this.language,
    required this.isThemeLight
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

  @override
  String toString() {
    return '$wakeUpHour, $wakeUpMinute, $sleepHour, $sleepMinute, $isNotificationOn, $language, $isThemeLight';
  }

}
