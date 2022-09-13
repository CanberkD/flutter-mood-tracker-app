import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/pages/input/view/widgets.dart';
import 'package:flutter_mood_tracker/product/model/date_time.dart';
import 'package:flutter_mood_tracker/product/model/mood_model.dart';
import 'package:flutter_mood_tracker/product/model/recorded_mood_model.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:mobx/mobx.dart';
part 'input_viewmodel.g.dart';

class InputViewModel = _InputViewModelBase with _$InputViewModel;

abstract class _InputViewModelBase with Store {
  late final SharedPref sharedPref;

  late List<RecordedMoodModel> moodList = sharedPref.recordedMoodModelList;
  void updateList () => moodList = sharedPref.recordedMoodModelList;

  @observable
  late ScrollController activityScrollController = ScrollController();
  @action
  void scrollToFirstActivty () => activityScrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  @observable
  late ScrollController peopleScrollController = ScrollController();
  @action
  void scrollToFirstPeople () => peopleScrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  @observable
  late List<String> activityList = List.empty(growable: true);
  @action
  void addItemToActivitys (String item) => activityList.add(item);  

  @observable
  List<bool> isActivityBoolList = List.empty(growable: true);
  @action 
  void resetActivityBoolList () => isActivityBoolList.fillRange(0, isActivityBoolList.length, false);

  @observable
  late List<String> peopleList = List.empty(growable: true);
  @action
  void addItemToPeopleList (String item) => peopleList.add(item);
  
  @observable
  List<bool> isPeoplesBoolList = List.empty(growable: true);

  List<bool> isButtonSelectedList = [true, false, false];

  _InputViewModelBase() {
    activityScrollController = ScrollController();
    sharedPref = SharedPref();
    activityList = sharedPref.activitys;
    isActivityBoolList = ObservableList.of(List.filled(activityList.length, false));
    peopleList = sharedPref.peopleList;
    isPeoplesBoolList = List.filled(peopleList.length, false, growable: true);
  }

  //Page view setup params.
  List<Widget> selectedMoodWidgets = [
    Padding(
      padding: EdgeInsets.all(PaddingSizes.toggleButtonChildPadding.value()),
      child: Image.asset(PngPaths(themeInfo: ThemeInfo.light).happy),
    ),
    Padding(
      padding: EdgeInsets.all(PaddingSizes.toggleButtonChildPadding.value()),
      child: Image.asset(PngPaths(themeInfo: ThemeInfo.light).notr),
    ),
    Padding(
      padding: EdgeInsets.all(PaddingSizes.toggleButtonChildPadding.value()),
      child: Image.asset(PngPaths(themeInfo: ThemeInfo.light).sad),
    )
  ];
  List<Widget> notSelectedMoodWidgets = [
    Padding(
      padding: EdgeInsets.all(PaddingSizes.toggleButtonChildPadding.value()),
      child: Image.asset(PngPaths(themeInfo: ThemeInfo.dark).happy),
    ),
    Padding(
      padding: EdgeInsets.all(PaddingSizes.toggleButtonChildPadding.value()),
      child: Image.asset(PngPaths(themeInfo: ThemeInfo.dark).notr),
    ),
    Padding(
      padding: EdgeInsets.all(PaddingSizes.toggleButtonChildPadding.value()),
      child: Image.asset(PngPaths(themeInfo: ThemeInfo.dark).sad),
    ),
  ];

  void saveButtonClicked(BuildContext context) {
    
    //Create moodModel
    MoodModel moodModel = MoodModel(
      activity: findActivity(isActivityBoolList, activityList),
      hour: ProjectDateTime().formattedHour,
      moodImgPath: findMood(isButtonSelectedList),
      peoplesWith: findPeopleList(isPeoplesBoolList, peopleList),
    );
    //Create recordedMoodModel with shortly before created moodModel
    RecordedMoodModel recordedMoodModel = RecordedMoodModel(
      date: MoodDateModel(
        day: ProjectDateTime().day,
        month: ProjectDateTime().month,
        year: ProjectDateTime().year
      ),
      moodList: [moodModel]
    );
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.home.name, (route) => false);

    sharedPref.addMoodToRecordedDate(recordedMoodModel);
    updateList();
  }
  @action
  void activityAddButtonClicked(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(RoundSizes.showModelMainSize.value()))),
        isScrollControlled: true,
        context: context,
        builder: (context) => AddItemWidget(
              isActivity: true,
              onAddPressed: (text) {
                saveActivityOnPressed(text, context);
              },
            ));
  }
  @action
  void peopleAddButtonClicked(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(RoundSizes.showModelMainSize.value()))),
        isScrollControlled: true,
        context: context,
        builder: (context) => AddItemWidget(
              isActivity: false,
              onAddPressed: (String text) {
                savePeopleOnPressed(text, context);
              },
            ));
  }

  void savePeopleOnPressed(String text, BuildContext context){
    addItemToPeopleList(text);
    isPeoplesBoolList.add(true);
    peopleList = List.of(peopleList.reversed);
    isPeoplesBoolList = List.of(isPeoplesBoolList.reversed);
    Navigator.pop(context);
    scrollToFirstPeople();
    sharedPref.saveStringListToStorage(peopleList, SharedPrefKeys.people_list);
  }
  void saveActivityOnPressed(String text, BuildContext context){
    addItemToActivitys(text);
    isActivityBoolList.add(true);
    activityList = List.from(activityList.reversed);
    isActivityBoolList = List.from(isActivityBoolList.reversed);
    Navigator.pop(context);
    scrollToFirstActivty();
    sharedPref.saveStringListToStorage(activityList, SharedPrefKeys.activity_list);
  }
  
  List<String> findPeopleList(List<bool> boolList, List<String> peopleList) {
    List<String> finalList = [];

    for (int i = 0; i < boolList.length; i++) {
      if (boolList[i] == true) {
        finalList.add(peopleList[i]);
      }
    }
    if (finalList.isNotEmpty) {
      return finalList;
    } else {
      return ['alone'.tr()];
    }
  }

  String findActivity(List<bool> boolList, List<String> activityList) {
    for (int i = 0; i < boolList.length; i++) {
      if (boolList[i] == true) {
        return activityList[i];
      }
    }
    return 'nothing'.tr();
  }

  String findMood(List<bool> list) {
    for (int i = 0; i < 3; i++) {
      if (list[i] == true) {
        switch (i) {
          case 0:
            return PngPaths(themeInfo: ThemeInfo.dark).happy;
          case 1:
            return PngPaths(themeInfo: ThemeInfo.dark).notr;
          case 2:
            return PngPaths(themeInfo: ThemeInfo.dark).sad;
        }
      }
    }
    return '';
  }

  List<Widget> getActivityWidgetList(Color textColor) {
    List<Widget> list = List.empty(growable: true);
  
    for (var item in activityList) {
      list.add(Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Text(item, style: TextStyle(color: textColor)),
      ));
    }
    return list;
  }

  void pageCloseButtonPressed(BuildContext context){
    Navigator.of(context).pop();
  }
}
