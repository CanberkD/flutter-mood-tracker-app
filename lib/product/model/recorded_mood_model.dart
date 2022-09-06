
import 'package:flutter_mood_tracker/product/model/mood_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recorded_mood_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RecordedMoodModel{
  late final List<MoodModel> moodList;
  late final MoodDateModel date;
  RecordedMoodModel({required this.moodList, required this.date});

  factory RecordedMoodModel.fromJson(Map<String, dynamic> json) => _$RecordedMoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordedMoodModelToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return ('Date: ${date.toString()}, MoodList: ${moodList.toString()}');
  }
}

@JsonSerializable(explicitToJson: true)
class MoodDateModel {
  late final int day;
  late final int month;
  late final int year;

  MoodDateModel({
    required this.day,
    required this.month,
    required this.year
  });

  @override
  String toString() {
    // TODO: implement toString
    return '$day$month$year';
  }

  factory MoodDateModel.fromJson(Map<String, dynamic> json) => _$MoodDateModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MoodDateModelToJson(this);

}