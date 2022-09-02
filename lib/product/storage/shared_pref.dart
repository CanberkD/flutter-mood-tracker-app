import 'package:flutter_mood_tracker/product/home/model/infogram_model.dart';
import 'package:flutter_mood_tracker/product/model/date_time.dart';
import 'package:flutter_mood_tracker/product/model/recorded_mood_model.dart';

import '../model/mood_model.dart';

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

    var mapOfHappy = {};

    for (var element in happyPeopleList) {
    if(!mapOfHappy.containsKey(element)) {
      mapOfHappy[element] = 1;
    } else {
      mapOfHappy[element] += 1;
    }
    }
    print('${mapOfHappy}happy');
    var mapOfSad = {};

    for (var element in sadPeopleList) {
    if(!mapOfSad.containsKey(element)) {
      mapOfSad[element] = 1;
    } else {
      mapOfSad[element] += 1;
    }
    }
    print('${mapOfSad}sad');

    //Liste çektiğinde boş olma ihtimalini handle et. Size'ına göre ilk 3 - 2 - 1 or empty göster.
    // Sonra placeler için de InfogramModel ekle.
    return [
      InfogramModel(title: 'Peoples make you happy', items: [mapOfHappy.keys.elementAt(0), mapOfHappy.keys.elementAt(1)]),
      InfogramModel(title: 'Peoples make you sad', items: [mapOfSad.keys.elementAt(0), mapOfSad.keys.elementAt(1)]),
      ];
  }
}