
import 'package:json_annotation/json_annotation.dart';

part 'mood_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MoodModel {
  late final String moodImgPath;
  late final String hour;
  late final String activity;
  late final List<String> peoplesWith;

  MoodModel({
    required this.moodImgPath, 
    required this.hour, 
    required this.activity, 
    required this.peoplesWith
    });

  factory MoodModel.fromJson(Map<String, dynamic> json) => _$MoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoodModelToJson(this);

  @override
  String toString() {
    return ('$moodImgPath, $hour, $activity, $peoplesWith');
  }
}
