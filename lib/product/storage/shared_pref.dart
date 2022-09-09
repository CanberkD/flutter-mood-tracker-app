import 'dart:convert';

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
  //RecordedMoodModel list.
  late List<RecordedMoodModel> recordedMoodModelList = List.empty(growable: true);
  SharedPref(){
    recordedMoodModelList = getListFromStorage() ?? [];
  }
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
    }
   saveListToStorage(recordedMoodModelList); //Saving new list to storage.
  }
  //First RecordedMoodModelList encoding to json then saving to storga.  
  void saveListToStorage(List<RecordedMoodModel> list){
    List<String> jsonRecordedMoodModelList = list.map((element) => jsonEncode(element.toJson())).toList();
    SharedPrefInstance.instance.setStringList(SharedPrefKeys.recorded_list.name, jsonRecordedMoodModelList);
  }
  //This method getting recordedMoodModels in storage.
  List<RecordedMoodModel>? getListFromStorage(){
    final itemsString = SharedPrefInstance.instance.getStringList(SharedPrefKeys.recorded_list.name);
    if (itemsString?.isNotEmpty ?? false) {
      return itemsString!.map((element) {
        final json = jsonDecode(element);
        if (json is Map<String, dynamic>) {
          return RecordedMoodModel.fromJson(json);
        }
        return RecordedMoodModel(date: MoodDateModel(day: 1,month: 1,year: 2022), moodList: []);
      }).toList();
    }
    return null;
  }
  
  //This method set today item list in homepage.
  List<MoodModel> makeToDayList(){
    for(var item in recordedMoodModelList){
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
    List<String> happyActivityList = [];
    List<String> sadActivityList = [];
    List<String> infogramModelItemsHappy = [];
    List<String> infogramModelItemsSad = [];
    List<String> infogramModelItemsHappyActivity = [];
    List<String> infogramModelItemsSadActivity = [];

    var mapOfSad = {};
    var mapOfHappy = {};
    var mapOfHappyActivitys = {};
    var mapOfSadActivitys = {};

    for(var item in recordedMoodModelList){
      for(var item2 in item.moodList) {
        if('assets/png/dark/happy.png' == item2.moodImgPath){
          happyPeopleList.addAll(item2.peoplesWith);
          happyActivityList.add(item2.activity);
        }
        else if('assets/png/dark/sad.png' == item2.moodImgPath){
          sadPeopleList.addAll(item2.peoplesWith);
          sadActivityList.add(item2.activity);
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

    for (var element in happyActivityList) {
      if(!mapOfHappyActivitys.containsKey(element)) {
        mapOfHappyActivitys[element] = 1;
      } else {
        mapOfHappyActivitys[element] += 1;
      }
    }

    for (var element in sadActivityList) {
      if(!mapOfSadActivitys.containsKey(element)) {
        mapOfSadActivitys[element] = 1;
      } else {
        mapOfSadActivitys[element] += 1;
      }
    }

    for(int i = 0; i < 3 ; i++){
      if(mapOfHappy.length >= (i + 1)) {
        infogramModelItemsHappy.add('${mapOfHappy.keys.elementAt(i)}, ${mapOfHappy.values.elementAt(i)} times ');
      }
      if(mapOfSad.length >= i + 1){
        infogramModelItemsSad.add('${mapOfSad.keys.elementAt(i)}, ${mapOfSad.values.elementAt(i)} times ');
      }
      if(mapOfHappyActivitys.length >= i + 1){
        infogramModelItemsHappyActivity.add('${mapOfHappyActivitys.keys.elementAt(i)}, ${mapOfHappyActivitys.values.elementAt(i)} times ');
      }
      if(mapOfSadActivitys.length >= i + 1){
        infogramModelItemsSadActivity.add('${mapOfSadActivitys.keys.elementAt(i)}, ${mapOfSadActivitys.values.elementAt(i)} times ');
      }
    }

    List<InfogramModel> finalList = List.empty(growable: true);

    if(infogramModelItemsHappy.isNotEmpty){
      finalList.add(InfogramModel(title: 'Peoples make you happy', items: infogramModelItemsHappy));
    }
    if(infogramModelItemsSad.isNotEmpty){
      finalList.add(InfogramModel(title: 'Peoples make you sad', items: infogramModelItemsSad));
    }
    if(infogramModelItemsHappyActivity.isNotEmpty){
      finalList.add(InfogramModel(title: 'Activitys make you happy', items: infogramModelItemsHappyActivity));
    }
    if(infogramModelItemsSadActivity.isNotEmpty){
      finalList.add(InfogramModel(title: 'Activitys make you sad', items: infogramModelItemsSadActivity));
    }
    return finalList;
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
  recorded_list,
}