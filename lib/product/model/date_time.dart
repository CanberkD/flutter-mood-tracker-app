import 'package:easy_localization/easy_localization.dart';

class ProjectDateTime {
  late final DateTime _dateTime;

  ProjectDateTime({DateTime? dateTime}) : _dateTime = dateTime ?? DateTime.now();

  final _months = [
   'january'.tr(),
   'february'.tr(), 
   'march'.tr(), 
   'april'.tr(),
   'may'.tr(), 
   'june'.tr(), 
   'july'.tr(), 
   'august'.tr(), 
   'september'.tr(), 
   'october'.tr(), 
   'november'.tr(), 
   'december'.tr()
   ];

  final _days = [
    'monday'.tr(),
    'tuesday'.tr(),
    'wednesday'.tr(),
    'thursday'.tr(),
    'friday'.tr(),
    'saturday'.tr(),
    'sunday'.tr()
  ]; 


  int get year => _dateTime.year;
  int get day => _dateTime.day;
  int get month => _dateTime.month;
  int get hour => _dateTime.hour;
  int get minute => _dateTime.minute;

  String get monthStr => _months[_dateTime.month - 1];
  String get dayStr => _days[_dateTime.day - 1];
  String get hourStr => (hour >= 10) ? hour.toString() : '0$hour';
  String get minuteStr =>  (minute >= 10) ? minute.toString() : '0$minute';

  String get formattedDate => '$day $monthStr $year';
  String get formattedHour => '$hourStr:$minuteStr';

  String convertStringDateForRecordedDay(int day, int month){
    String monthStr = _months[month - 1];
    return '$day $monthStr';
  }
  String convertStringDateForRecordedDayAll(int day, int month, int year){
    String monthStr = _months[month - 1];
    return '$day $monthStr $year';
  }
}
