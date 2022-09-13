

import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/pages/home/model/infogram_model.dart';
import 'package:flutter_mood_tracker/product/model/date_time.dart';
import 'package:flutter_mood_tracker/product/model/mood_model.dart';
import 'package:flutter_mood_tracker/product/model/recorded_mood_model.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:mobx/mobx.dart';

part 'homepage_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store {
  late final SharedPref sharedPref;
  late final ProjectDateTime _dateTime;

  late PngPaths pngPaths = PngPaths(themeInfo: ThemeInfo.dark);
  
  @observable
  int dayIndex = ProjectDateTime().day;
  @observable
  int monthIndex = ProjectDateTime().month;
  @observable
  int yearIndex = ProjectDateTime().year;
 
  late List<DropdownMenuItem<int>> dropdownDayList = List.empty(growable: true);
  late List<DropdownMenuItem<int>> dropdownMonthList = List.empty(growable: true);
  late List<DropdownMenuItem<int>> dropdownYearList = List.empty(growable: true);
  
  _HomePageViewModelBase(){
  
    sharedPref = SharedPref();

    _dateTime = ProjectDateTime(dateTime: DateTime.now());

    for(int i = 0; i<31; i++){
      dropdownDayList.add(DropdownMenuItem(value: i+1,child: Text((i+1).toString()),));
      if(i < 12){
        dropdownMonthList.add(DropdownMenuItem(value: i+1,child: Text((i+1).toString()),));
      }
    }
    for(int i = 2021; i<= 2030; i++){
      dropdownYearList.add(DropdownMenuItem(value: i+1,child: Text((i+1).toString()),));
    }
  }


  //Getting saved mood of today. 
  late List<MoodModel> todayList = sharedPref.makeToDayList();  
  //Getting infogram item list calculated in sharedPref.
  late List<InfogramModel> infogramList = sharedPref.setInfogramModelList();
  //Getting all recorded list.
  @observable
  late ObservableList<RecordedMoodModel> recordedList = ObservableList.of(sharedPref.recordedMoodModelList);

   
  //Getter method for date string under the Hello text.
  String get helloBarDateStr => _dateTime.formattedDate;
  
  //Filter recorded list
  void filterRecordedList(BuildContext context){
    MoodDateModel selectedDate = MoodDateModel(
        day: dayIndex, month: monthIndex, year: yearIndex);
    ObservableList<RecordedMoodModel> filteredList =
        ObservableList.of(List.empty(growable: true));

    for (var item in sharedPref.recordedMoodModelList) {
      if (item.date.toString() == selectedDate.toString()) {
        filteredList.add(item);
      }
    }
    recordedList = filteredList;
    Navigator.pop(context);
  }

  //Clear filter
  void clearFilter(BuildContext context){
  recordedList = ObservableList.of(sharedPref.recordedMoodModelList);
  dayIndex = ProjectDateTime().day;
  monthIndex = ProjectDateTime().month;
  yearIndex = ProjectDateTime().year;
  }

  void setPngPaths(BuildContext context){
    pngPaths = PngPaths(themeInfo: Theme.of(context).brightness == Brightness.light ? ThemeInfo.dark: ThemeInfo.light);
  }

  //Future<void> notificationSetup(BuildContext context) async {
  //  //AwesomeNotificationService notificationService = AwesomeNotificationService();
  //}

}