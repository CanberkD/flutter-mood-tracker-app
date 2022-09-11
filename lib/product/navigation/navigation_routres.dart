
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/pages/home/view/homepage_view.dart';
import 'package:flutter_mood_tracker/product/pages/input/view/input_view.dart';
import 'package:flutter_mood_tracker/product/pages/recorded_day/view/recorded_day_view.dart';
import 'package:flutter_mood_tracker/product/pages/settings/view/settings_view.dart';

class NavigationRoutes {
  final Map<String, Widget Function(BuildContext)> routes = {
        Routes.home.name : (context) => const HomePageView(),
        Routes.addMood.name : (context) => const InputView(),
        Routes.recordedDay.name : (context) => const RecordedDayView(),
        Routes.settings.name : (context) => SettingsView(), 
  };
}

enum Routes {home, addMood, recordedDay, settings,} 
extension RoutesExtension on Routes {
  String get name {
    switch(this){
      case Routes.home:
        return "/";
      case Routes.addMood:
        return "/addMood";
      case Routes.recordedDay:
        return "/recordedDay";
      case Routes.settings:
        return "/settings";
    }
  }
}