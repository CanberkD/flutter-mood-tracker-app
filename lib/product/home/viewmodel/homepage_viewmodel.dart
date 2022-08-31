import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:mobx/mobx.dart';

part 'homepage_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store {
  PngPaths pngPaths = PngPaths(themeInfo: ThemeInfo.dark);


}