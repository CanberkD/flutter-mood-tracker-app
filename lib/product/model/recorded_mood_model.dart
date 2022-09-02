
import 'package:flutter_mood_tracker/product/model/mood_model.dart';


class RecordedMoodModel{
  late final List<MoodModel> moodList;
  late final MoodDateModel date;
  RecordedMoodModel({required this.moodList, required this.date});

}

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

}