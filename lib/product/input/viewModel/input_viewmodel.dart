import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:mobx/mobx.dart';
part 'input_viewmodel.g.dart';

class InputViewModel = _InputViewModelBase with _$InputViewModel;

abstract class _InputViewModelBase with Store {

  List<bool> isButtonSelectedList = [true, false, false];

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

  List<bool> activityBoolList = List.filled(SharedPref().activitys.length, false);
  List<Widget> activtyChildWidgetsNotSelected = SharedPref().getActivityWidgetList(ProjectColors.primaryBlack.value());
  List<Widget> activtyChildWidgetsSelected = SharedPref().getActivityWidgetList(ProjectColors.primaryWhite.value());
  
  List<String> peoplesList = SharedPref().peopleList;
  List<bool> isPeoplesBoolList = List.filled(SharedPref().peopleList.length, false);

  void saveButtonClicked(){
    print(isButtonSelectedList);
    print(activityBoolList);
    print(isPeoplesBoolList);
  }
}