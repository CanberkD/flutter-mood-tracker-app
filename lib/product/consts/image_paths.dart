class PngPaths{
  late String _basePngPath = "assets/png";
  final String _darkPath = "/dark";
  final String _lightPath = "/light";
  final ThemeInfo themeInfo;
  PngPaths({required this.themeInfo}){
    (themeInfo == ThemeInfo.light) ?  _basePngPath += _lightPath : _basePngPath += _darkPath;
  }

  String getLightPlus(){
    return "assets/png/light/plus.png";
  }

  String get setting => "$_basePngPath/setting.png";
  String get clock => "$_basePngPath/clock.png";
  String get filter => "$_basePngPath/filter.png";
  String get happy => "$_basePngPath/happy.png";
  String get notification => "$_basePngPath/notification.png";
  String get notr => "$_basePngPath/notr.png";
  String get plus => "$_basePngPath/plus.png";
  String get sad => "$_basePngPath/sad.png";
  String get theme => "$_basePngPath/theme.png";
  String get world => "$_basePngPath/world.png";
  String get close => "$_basePngPath/close.png";
}

enum ThemeInfo {light, dark}
