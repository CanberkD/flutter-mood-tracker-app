import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';
import 'package:flutter_mood_tracker/product/pages/settings/model/settings_model.dart';
import 'package:flutter_mood_tracker/product/service/awesome_notifications_service.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:flutter_mood_tracker/product/theme/theme_store.dart';
import 'package:provider/provider.dart';

//For reminder notification -------------------------------
void showNotification() {
  AwesomeNotificationService().simpleNotificationForReminder();
  nextAlarmSetup();
}

void nextAlarmSetup() async {
  AndroidAlarmManager.cancel(0);
  const int alarmId = 0;
  DateTime dateTime = DateTime.now();
  await SharedPrefInstance.init();
  SettingsModel settingsModel = SharedPref().getSavedSettingsModel();
  int countOfNotif = settingsModel.notificationCountInADay;
  int wakeUpHours = settingsModel.sleepHour - settingsModel.wakeUpHour;
  int intervalMinute = ((wakeUpHours * 60) ~/ countOfNotif);
  int intervalHour = 0;
  if (intervalMinute >= 60) {
    intervalHour = intervalMinute ~/ 60;
    intervalMinute = intervalMinute % 60;
  }

  if (settingsModel.isNotificationOn) {
    if (dateTime.hour + intervalHour >= settingsModel.wakeUpHour &&
        dateTime.hour + intervalHour < settingsModel.sleepHour) {
      AndroidAlarmManager.oneShot(
          Duration(minutes: (intervalMinute + (intervalHour * 60))),
          alarmId,
          showNotification);
    } else {
      AndroidAlarmManager.oneShot(
          Duration(
              minutes: ((settingsModel.wakeUpHour - dateTime.hour) * 60) + 60),
          alarmId,
          showNotification);
    }
  }
}
//For reminder notification -------------------------------

Future<void> main() async {
  //For sharedPrefInstance.
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefInstance.init();

  //Notification service initializing.
  AwesomeNotificationService().initialize([
    NotificationChannel(
      channelKey: ChannelKeys.moodReminder.name,
      channelName: 'Mood reminder',
      channelDescription:
          'Notification of this channel reminds you input your mood.',
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
    NotificationChannel(
        channelKey: ChannelKeys.notificationOn.name,
        channelName: 'Notification on',
        channelDescription:
            'We will send notification through this channel when you set notification on.',
        importance: NotificationImportance.High,
        channelShowBadge: false)
  ]);

  //If device android initialize alarm
  if (Platform.isAndroid) {
    AndroidAlarmManager.initialize();
  }

  runApp(Provider(
    create: (context) => ThemeStore(), 
    child: const MyApp()),);

  //If device android initialize alarm
  if (Platform.isAndroid) {
    nextAlarmSetup();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

  ThemeStore themeStore = Provider.of<ThemeStore>(context, listen: true);

    return Observer(
      builder: (context) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: themeStore.themeData,
        initialRoute: Routes.home.name,
        routes: NavigationRoutes().routes,
      );
    });
  }
}
