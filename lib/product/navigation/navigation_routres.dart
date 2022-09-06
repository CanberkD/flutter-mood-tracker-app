
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/home/view/homepage_view.dart';
import 'package:flutter_mood_tracker/product/input/view/input_view.dart';

class NavigationRoutes {
  final Map<String, Widget Function(BuildContext)> routes = {
        Routes.home.name : (context) => const HomePageView(),
        Routes.addMood.name : (context) => const InputView(),
  };
}

enum Routes {home, addMood} 
extension RoutesExtension on Routes {
  String get name {
    switch(this){
      case Routes.home:
        return "/";
      case Routes.addMood:
        return "/addMood";
    }
  }
}