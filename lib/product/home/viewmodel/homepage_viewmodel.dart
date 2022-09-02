
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
  
  PngPaths pngPaths = PngPaths(themeInfo: ThemeInfo.dark);
  late final ProjectDateTime _dateTime = ProjectDateTime(dateTime: DateTime.now());
  
  String get helloBarDateStr => _dateTime.formattedDate;

  List<MoodModel> todayList = SharedPref().makeToDayList();
  

  List<InfogramModel> infogramList = SharedPref().setInfogramModelList();

  List<RecordedMoodModel> recordedList = SharedPref().recordedMoodModelList;
}