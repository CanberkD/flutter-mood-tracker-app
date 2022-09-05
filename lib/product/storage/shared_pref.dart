import 'package:flutter_mood_tracker/product/home/model/infogram_model.dart';
import 'package:flutter_mood_tracker/product/model/date_time.dart';
import 'package:flutter_mood_tracker/product/model/recorded_mood_model.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/mood_model.dart';

class SharedPrefInstance {
  //SharedPreference instance singleton.
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async => instance = await SharedPreferences.getInstance();
}

class SharedPref{

  List<RecordedMoodModel> recordedMoodModelList =  [
    RecordedMoodModel(moodList: [
      MoodModel(
      activity: 'Work', hour: '12:22', moodImgPath: 'assets/png/dark/happy.png', peoplesWith: ['Alone', 'John'], 
      ),
      MoodModel(
      activity: 'Work', hour: '15:22', moodImgPath: 'assets/png/dark/happy.png', peoplesWith: ['Alone'], 
      ),
    ], date: MoodDateModel(day: 3, month: 9, year: 2022)),
    RecordedMoodModel(moodList: [
      MoodModel(
      activity: 'Work', hour: '10:22', moodImgPath: 'assets/png/dark/happy.png', peoplesWith: ['Alone'], 
      ),
      MoodModel(
      activity: 'Work', hour: '15:22', moodImgPath: 'assets/png/dark/sad.png', peoplesWith: ['Alone', 'Bill', 'Dutch'], 
      ),
    ], date: MoodDateModel(day: 2, month: 9, year: 2022)),
    RecordedMoodModel(moodList: [
      MoodModel(
      activity: 'Work', hour: '10:22', moodImgPath: 'assets/png/dark/sad.png', peoplesWith: ['Alone'], 
      ),
      MoodModel(
      activity: 'Work', hour: '15:22', moodImgPath: 'assets/png/dark/sad.png', peoplesWith: ['Bill',], 
      ),
    ], date: MoodDateModel(day: 1, month: 9, year: 2022)),
  ];

  void addToRecordedMoodModelList (RecordedMoodModel item) => recordedMoodModelList.add(item);

  //This method try to find record of selected date. if do not, return null.
  RecordedMoodModel? getSelectedDateRecorded(MoodDateModel moodDate){
    for(var item in recordedMoodModelList){
      if(item.date.toString() == moodDate.toString()){
        return item;
      }
    }
    return null;
  }
  //This method adding moodmodel with check isTodayRecordedMoodModel exist. If exist, add into recordedMoodModel. If not exist, creates new one.
  void addMoodToRecordedDate(RecordedMoodModel moodModel){
    //First try to find record of today, if did not found, create new recordedMoodModel.
    if(getSelectedDateRecorded(moodModel.date) == null) { // Check is exist
      recordedMoodModelList.add(moodModel); //if not exist directly add record.
    }
    else { //if exist
      getSelectedDateRecorded(moodModel.date)!.moodList.add(moodModel.moodList.first); //Add mood to record already exist.
      RecordedMoodModel record = getSelectedDateRecorded(moodModel.date)!; // Saving record because will remove next line.
      recordedMoodModelList.removeWhere((element) => ( // Removing record already exist.
          moodModel.date.toString() == element.date.toString()
        )
      );
      recordedMoodModelList.add(record); // Record of shortly before updated moodlist's adding recordedMoodList.
      //TODO: clear shared then save new item added list shared pref. 
    }
  }
  
  //This method set today item list in homepage.
  List<MoodModel> makeToDayList(){
    for(var item in recordedMoodModelList){
      print(MoodDateModel(day: ProjectDateTime().day, month: ProjectDateTime().month, year: ProjectDateTime().year).toString().toString());
      print(item.date.toString());
      if(MoodDateModel(day: ProjectDateTime().day, month: ProjectDateTime().month, year: ProjectDateTime().year).toString() == item.date.toString()){
        return item.moodList;
      }
    }
    return [];
  }

  //This method set infogram item list in homepage.
  List<InfogramModel> setInfogramModelList(){
    List<String> happyPeopleList = [];
    List<String> sadPeopleList = [];
    List<String> infogramModelItemsHappy = [];
    List<String> infogramModelItemsSad = [];

    var mapOfSad = {};
    var mapOfHappy = {};


    for(var item in recordedMoodModelList){
      for(var item2 in item.moodList) {
        if('assets/png/dark/happy.png' == item2.moodImgPath){
          happyPeopleList.addAll(item2.peoplesWith);
        }
        else if('assets/png/dark/sad.png' == item2.moodImgPath){
          sadPeopleList.addAll(item2.peoplesWith);
        }
      }
    }

    for (var element in happyPeopleList) {
      if(!mapOfHappy.containsKey(element)) {
        mapOfHappy[element] = 1;
      } else {
        mapOfHappy[element] += 1;
      }
    }

    for (var element in sadPeopleList) {
      if(!mapOfSad.containsKey(element)) {
        mapOfSad[element] = 1;
      } else {
        mapOfSad[element] += 1;
      }
    }

    for(int i = 0; i < 3 ; i++){
      if(mapOfHappy.length >= (i + 1)) {
        infogramModelItemsHappy.add(mapOfHappy.keys.elementAt(i));
      }
      if(mapOfSad.length >= i + 1){
        infogramModelItemsSad.add(mapOfSad.keys.elementAt(i));
      }
    }

    if(infogramModelItemsSad.isNotEmpty && infogramModelItemsHappy.isNotEmpty){
      return [
        InfogramModel(title: 'Peoples make you happy', items: infogramModelItemsHappy),
        InfogramModel(title: 'Peoples make you sad', items: infogramModelItemsSad),
      ];
    }
    else if (infogramModelItemsSad.isNotEmpty) {
      return [InfogramModel(title: 'Peoples make you sad', items: infogramModelItemsSad)];
    }
    else if (infogramModelItemsHappy.isEmpty) {
      return [InfogramModel(title: 'Peoples make you happy', items: infogramModelItemsHappy)];
    }
    else {
      return [];
    }
  }

  //This method getting activity and people list in storage saved by user. 
  ObservableList<String> activitys = ObservableList.of(SharedPrefInstance.instance.getStringList(SharedPrefKeys.activity_list.name) ?? []);
  ObservableList<String> peopleList = ObservableList.of(SharedPrefInstance.instance.getStringList(SharedPrefKeys.people_list.name) ?? []);
  
  //This method saves to storage activity||peopleList added by user. 
  void saveStringListToStorage(List<String> list, SharedPrefKeys key){
    SharedPrefInstance.instance.setStringList(key.name, list);
  }

}

enum SharedPrefKeys {
  activity_list,
  people_list,
}