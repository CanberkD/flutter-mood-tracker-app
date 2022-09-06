
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/home/model/infogram_model.dart';
import 'package:flutter_mood_tracker/product/model/date_time.dart';
import 'package:flutter_mood_tracker/product/model/mood_model.dart';
import 'package:flutter_mood_tracker/product/model/recorded_mood_model.dart';
import 'package:mobx/mobx.dart';

import '../../storage/shared_pref.dart';


part 'homepage_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store {
  late final SharedPref sharedPref;
  late final ProjectDateTime _dateTime;
  late final PngPaths pngPaths;
  
  _HomePageViewModelBase(){

    sharedPref = SharedPref();
    List<dynamic> recordedList = sharedPref.getListFromStorage() ?? [];

    _dateTime = ProjectDateTime(dateTime: DateTime.now());
    pngPaths = PngPaths(themeInfo: ThemeInfo.dark);
  
  }
  
  //Getting saved mood of today. 
  late List<MoodModel> todayList = sharedPref.makeToDayList();  
  //Getting infogram item list calculated in sharedPref.
  late List<InfogramModel> infogramList = sharedPref.setInfogramModelList();
  //Getting all recorded list.
  late List<RecordedMoodModel> recordedList = sharedPref.recordedMoodModelList;

   
  //Getter method for date string under the Hello text.
  String get helloBarDateStr => _dateTime.formattedDate;



}