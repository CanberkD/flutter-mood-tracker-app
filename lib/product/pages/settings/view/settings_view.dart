

import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/core/components/basic/bottom_sheet_divider.dart';
import 'package:flutter_mood_tracker/core/components/button/toggle_button.dart';
import 'package:flutter_mood_tracker/main.dart';
import 'package:flutter_mood_tracker/product/components/button/go_back_button.dart';
import 'package:flutter_mood_tracker/product/components/text/header_text.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/pages/settings/model/settings_model.dart';
import 'package:flutter_mood_tracker/product/service/awesome_notifications_service.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:flutter_mood_tracker/product/theme/theme_store.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);

  SharedPref sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const GoBackIconButton(),
        ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value()),
            child: const Align(alignment: Alignment.centerLeft, child: HeaderTextWidget(text: 'Settings')),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: PaddingSizes.mainColumnVerticalPadding.value()),
              child: ListView(
                children: [
                  SettingsMenuItem(
                    onPressed: Platform.isIOS ? () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification works only on Android.'),));} : () async {
                      final result = await TimePicker.show<DateTime?>(
                        context: context,
                        sheet: TimePickerSheet(
                          wheelNumberSelectedStyle: SettingsConst.timePickerTitleTextStyle,
                          minuteTitleStyle: SettingsConst.timePickerTitleTextStyle,
                          hourTitleStyle: SettingsConst.timePickerTitleTextStyle,
                          sheetCloseIcon: Icons.close,
                          sheetCloseIconColor: ProjectColors.primaryBlack.value(),
                          saveButtonColor: ProjectColors.primaryBlue.value(),
                          sheetTitle: 'Set waking up time',
                          hourTitle: 'Hour',
                          minuteTitle: 'Minute',
                          saveButtonText: 'Save',
                        ),
                      );
                      if(result != null){
                        SharedPref sharedPref = SharedPref();
                        SettingsModel savedSettingsModel = sharedPref.getSavedSettingsModel();
                        savedSettingsModel.setWakeUpHour = result.hour;
                        savedSettingsModel.setWakeUpMinute = result.minute;
                        sharedPref.saveSettingsModel(savedSettingsModel);
                        nextAlarmSetup();
                      }
                    }, 
                    imgPath: PngPaths(themeInfo: Theme.of(context).brightness == Brightness.light ?  ThemeInfo.dark: ThemeInfo.light).clock,
                    text: 'Set waking up time',
                  ),
                  const Divider(height: 1),
                  SettingsMenuItem(
                    onPressed: Platform.isIOS ? () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification works only on Android.'),));} : () async {
                      final result = await TimePicker.show<DateTime?>(
                        context: context,
                        sheet: TimePickerSheet(
                          wheelNumberSelectedStyle: SettingsConst.timePickerTitleTextStyle,
                          minuteTitleStyle: SettingsConst.timePickerTitleTextStyle,
                          hourTitleStyle: SettingsConst.timePickerTitleTextStyle,
                          sheetCloseIcon: Icons.close,
                          sheetCloseIconColor: ProjectColors.primaryBlack.value(),
                          saveButtonColor: ProjectColors.primaryBlue.value(),
                          sheetTitle: 'Set sleep time',
                          hourTitle: 'Hour',
                          minuteTitle: 'Minute',
                          saveButtonText: 'Save',
                        ),
                      );
                      if(result != null){
                        SharedPref sharedPref = SharedPref();
                        SettingsModel savedSettingsModel = sharedPref.getSavedSettingsModel();
                        savedSettingsModel.setSleepHour = result.hour;
                        savedSettingsModel.setSleepMinute = result.minute;
                        sharedPref.saveSettingsModel(savedSettingsModel);
                        nextAlarmSetup();
                      }
                    }, 
                    imgPath: PngPaths(themeInfo: Theme.of(context).brightness == Brightness.light ?  ThemeInfo.dark: ThemeInfo.light).clock,
                    text: 'Set sleep time',
                  ),
                  const Divider(height: 1),
                  SettingsMenuItem(
                    onPressed: Platform.isIOS ? () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification works only on Android.'),));} : () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(RoundSizes.showModelMainSize.value()))),
                        context: context, 
                        builder: (context) {
                          return NotificationWidget(sharedPref: sharedPref);
                        },);
                    }, 
                    imgPath: PngPaths(themeInfo: Theme.of(context).brightness == Brightness.light ?  ThemeInfo.dark: ThemeInfo.light).notification,
                    text: 'Notification',
                  ),
                  const Divider(height: 1),
                  SettingsMenuItem(
                    onPressed: () {}, 
                    imgPath: PngPaths(themeInfo: Theme.of(context).brightness == Brightness.light ?  ThemeInfo.dark: ThemeInfo.light).world,
                    text: 'Language',
                  ),
                  const Divider(height: 1),
                  SettingsMenuItem(
                    onPressed: () {
                      //Changing theme. User settings in storage, change inside this method.
                    }, 
                    imgPath: PngPaths(themeInfo: Theme.of(context).brightness == Brightness.light ?  ThemeInfo.dark: ThemeInfo.light).theme,
                    text: 'Theme',
                    trailingWidget: Padding(
                      padding: EdgeInsets.symmetric(vertical: SettingsConst.themeToggleButtonPadding),
                      child: ToggleButton(
                        width: SettingsConst.themeToggleButtonWidth,
                        onpressed: (isSelected) {
                          context.read<ThemeStore>().switchTheme();
                        }, 
                        notSelectedColor:ProjectColors.primaryBlack.value(), 
                        selectedColor:  ProjectColors.primaryWhite.value(), 
                        notSelectedChild: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Dark'),
                        ), 
                        selectedChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Light', style: TextStyle(color: ProjectColors.primaryBlack.value()),),
                        ), 
                        isShadowVisible: false,
                        isSelected: sharedPref.getSavedSettingsModel().isThemeLight
                        ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.sharedPref,
  }) : super(key: key);

  final SharedPref sharedPref;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const BottomSheetTopLine(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Expanded(flex: 2,child: SubTitle(text: 'Notifications:')),
                    Expanded(
                      flex: 1,
                      child: ToggleButton(
                        onpressed: (isSelected) {
                          AwesomeNotificationService notificationService = AwesomeNotificationService();
                          SettingsModel settingsModel = sharedPref.getSavedSettingsModel();
                          settingsModel.setIsNotificationOn = isSelected;
                          sharedPref.saveSettingsModel(settingsModel);
                          if (isSelected) {
                            notificationService.simpleNotificationNotificationOn();
                            nextAlarmSetup();
                          }
                          else {
                            notificationService.cancelAllScheduledNotifications();
                            AndroidAlarmManager.cancel(0);
                          }
                        },
                        borderRadius: 5,
                        width: SettingsConst.notificationOnOffButtonWidth,
                        heigth: SettingsConst.notificationOnOffButtonHeight,
                        notSelectedColor: ProjectColors.primaryWhite.value(), 
                        selectedColor: ProjectColors.primaryBlue.value(), 
                        notSelectedChild: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Off'),
                        ), 
                        selectedChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('On', style: TextStyle(color: ProjectColors.primaryWhite.value()),),
                        ), 
                        isSelected: sharedPref.getSavedSettingsModel().isNotificationOn),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(flex: 2,child: SubTitle(text: 'How many times would you like to receive notifications in a day?')),
                    Expanded(flex: 1, child: Center(child: NotificationCountSelection(sharedPref: sharedPref))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsMenuItem extends StatelessWidget {
  const SettingsMenuItem({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.imgPath,
    this.trailingWidget,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final String imgPath;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: PaddingSizes.mainColumHorizontalPadding.value()),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            width: SettingsConst.mainMenuIconSize,
            height: SettingsConst.mainMenuIconSize,
            child: Image.asset(imgPath)
          ),
          title: Text(text),
          trailing: trailingWidget ?? Icon(Icons.chevron_right, color: Theme.of(context).brightness == Brightness.light ?  ProjectColors.primaryBlack.value() : ProjectColors.primaryWhite.value(),),
        ),
      ),
    );
  }
}

class NotificationCountSelection extends StatefulWidget {

  const NotificationCountSelection({
    Key? key, 
    required this.sharedPref,
  }) : super(key: key);

  final SharedPref sharedPref;

  @override
  State<NotificationCountSelection> createState() => _NotificationCountSelectionState();
}

class _NotificationCountSelectionState extends State<NotificationCountSelection> {
  int counterValue = 4;
  late List<DropdownMenuItem<int>> dropDownCounterItemList;

  @override
  void initState() {
    super.initState();
    dropDownCounterItemList = List.empty(growable: true);
    for(int i = 1; i < SettingsConst.maxNotificationCount; i++){
      dropDownCounterItemList.add(DropdownMenuItem(value: i,child: Text(i.toString()),));
    }
    counterValue = widget.sharedPref.getSavedSettingsModel().notificationCountInADay;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<int>(
      dropdownMaxHeight: MediaQuery.of(context).size.height * 0.3,
      dropdownWidth: 70,
      underline: Divider(color: ProjectColors.primaryBlue.value(), height: 2,),
      value: counterValue,
      items: dropDownCounterItemList,
      onChanged: (value) {
        setState(() {
          SettingsModel settingsModel = widget.sharedPref.getSavedSettingsModel();
          settingsModel.setNotificationCountInADay = value ?? counterValue;
          counterValue = value ?? counterValue;
          widget.sharedPref.saveSettingsModel(settingsModel);
          nextAlarmSetup();
        });
      },
    );
  }
}
class SettingsConst {
  static double get mainMenuIconSize => 24.0; 
  static TextStyle timePickerTitleTextStyle =   TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ProjectColors.primaryBlack.value());
  static double get notificationOnOffButtonWidth => 70.0;
  static double get notificationOnOffButtonHeight => 40.0;
  static double get themeToggleButtonPadding => 13.0;
  static double get themeToggleButtonWidth => 70;
  static int get maxNotificationCount => 10;
}