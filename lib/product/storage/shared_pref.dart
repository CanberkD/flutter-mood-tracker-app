import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/home/model/infogram_model.dart';
import 'package:flutter_mood_tracker/product/model/date_time.dart';
import 'package:flutter_mood_tracker/product/model/recorded_mood_model.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/mood_model.dart';

class SharedPrefInstance {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async => instance = await SharedPreferences.getInstance();
}

class SharedPref{

  //Fake recordedMoodList
  List<RecordedMoodModel> get recordedMoodModelList => [
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

  ObservableList<String> activitys = ObservableList.of(SharedPrefInstance.instance.getStringList(SharedPrefKeys.activity_list.name) ?? []);
  ObservableList<String> peopleList = ObservableList.of(SharedPrefInstance.instance.getStringList(SharedPrefKeys.people_list.name) ?? []);
  void saveStringListToStorage(List<String> list, SharedPrefKeys key){
    SharedPrefInstance.instance.setStringList(key.name, list);
  }

  List<Widget> activityTextWidgetList (Color childTextColor){
    List<Widget> list = [];
    for(var item in activitys){
      list.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(item, style: TextStyle(color: childTextColor),),
      ));
    }    
    return list;
  } 

}

enum SharedPrefKeys {
  activity_list,
  people_list,
}