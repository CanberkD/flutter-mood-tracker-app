import 'package:flutter_mood_tracker/product/consts/text.dart';

class ProjectDateTime {
  late final DateTime _dateTime;

  ProjectDateTime({DateTime? dateTime}) : _dateTime = dateTime ?? DateTime.now();

  final _months = [
   ProjectText.january,
   ProjectText.february, 
   ProjectText.march, 
   ProjectText.april,
   ProjectText.may, 
   ProjectText.june, 
   ProjectText.july, 
   ProjectText.august, 
   ProjectText.september, 
   ProjectText.october, 
   ProjectText.november, 
   ProjectText.december
   ];

  final _days = [
    ProjectText.monday,
    ProjectText.tuesday,
    ProjectText.wednesday,
    ProjectText.thursday,
    ProjectText.friday,
    ProjectText.saturday,
    ProjectText.sunday
  ]; 


  int get year => _dateTime.year;
  int get day => _dateTime.day;
  int get month => _dateTime.month;
  int get hour => _dateTime.hour;
  int get minute => _dateTime.minute;

  String get monthStr => _months[_dateTime.month - 1];
  String get dayStr => _days[_dateTime.day - 1];
  String get hourStr => (hour >= 10) ? hour.toString() : '0$hour';
  String get minuteStr =>  (minute >= 10) ? minute.toString() : '0$hour';

  String get formattedDate => '$day $monthStr $year';
  String get formattedHour => '$hourStr:$minuteStr';

  String convertStringDateForRecordedDay(int day, int month){
    String monthStr = _months[month - 1];
    return '$day $monthStr';
  }
}
