import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/pages/settings/model/settings_model.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:flutter_mood_tracker/product/theme/theme.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStoreBase with _$ThemeStore;

abstract class _ThemeStoreBase with Store {
  
  late final SharedPref sharedPref;
  late SettingsModel settingsModel;

  _ThemeStoreBase(){
    sharedPref = SharedPref();
    settingsModel = sharedPref.getSavedSettingsModel();
  }

  @observable
  late ThemeData themeData = settingsModel.isThemeLight ? CustomThemeData().light() : CustomThemeData().dark();

  @observable
  late bool isThemeLight = settingsModel.isThemeLight;

  @action 
  void switchTheme(){

    if(isThemeLight){
      themeData = CustomThemeData().dark();
      isThemeLight = !isThemeLight;
    }
    else {
      themeData = CustomThemeData().light();
      isThemeLight = !isThemeLight;
    }

    settingsModel.setIsThemeLight = isThemeLight;
    sharedPref.saveSettingsModel(settingsModel);

  }


}