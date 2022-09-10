
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/go_back_button.dart';
import 'package:flutter_mood_tracker/product/components/text/header_text.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/service/notification_service.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);
  
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
                    onPressed: () async {
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
                        final SharedPref sharedPref = SharedPref();
                        sharedPref.saveInt(result.hour, SharedPrefKeys.wakeup_hour);
                        sharedPref.saveInt(result.minute, SharedPrefKeys.wakeup_minute);
                      }
                    }, 
                    imgPath: PngPaths(themeInfo: ThemeInfo.dark).clock,
                    text: 'Set waking up time',
                  ),
                  const Divider(height: 1),
                  SettingsMenuItem(
                    onPressed: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(RoundSizes.showModelMainSize.value()))),
                        context: context, 
                        builder: (context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Expanded(child: SubTitle(text: 'Notifications:')),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(onPressed: () {
                                            SharedPref sharedPref = SharedPref();
                                            sharedPref.saveInt(1, SharedPrefKeys.is_notification_on);
                                            NotificationService().startReminderNotificaiton();
                                            Navigator.pop(context);
                                          }, child: const Text('On')),
                                          TextButton(onPressed: () {
                                            SharedPref().saveInt(0, SharedPrefKeys.is_notification_on);
                                            NotificationService().stopReminderNotification();
                                            Navigator.pop(context);
                                          }, child: const Text('Off')),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Expanded(child: SubTitle(text: 'Density:')),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                SharedPref sharedPref = SharedPref();
                                                sharedPref.saveInt(
                                                    0,
                                                    SharedPrefKeys
                                                        .is_notification_hourly);
                                                NotificationService()
                                                    .startReminderNotificaiton();
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Daily')),
                                          ElevatedButton(
                                              onPressed: () {
                                                SharedPref().saveInt(
                                                    1,
                                                    SharedPrefKeys
                                                        .is_notification_hourly);
                                                 NotificationService()
                                                    .startReminderNotificaiton();
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Hourly'))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },);
                    }, 
                    imgPath: PngPaths(themeInfo: ThemeInfo.dark).notification,
                    text: 'Notification',
                  ),
                  const Divider(height: 1),
                  SettingsMenuItem(
                    onPressed: () {}, 
                    imgPath: PngPaths(themeInfo: ThemeInfo.dark).world,
                    text: 'Language',
                  ),
                  const Divider(height: 1),
                  SettingsMenuItem(
                    onPressed: () {}, 
                    imgPath: PngPaths(themeInfo: ThemeInfo.dark).theme,
                    text: 'Theme',
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
            child: Image.asset(imgPath)),
          title: Text(text),
          trailing: trailingWidget ?? Icon(Icons.chevron_right, color: ProjectColors.primaryBlack.value(),),
        ),
      ),
    );
  }
}

class SettingsConst {
  static double get mainMenuIconSize => 24.0; 
  static TextStyle timePickerTitleTextStyle =   TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ProjectColors.primaryBlack.value());
}