import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';
import 'package:flutter_mood_tracker/product/pages/settings/model/settings_model.dart';
import 'package:flutter_mood_tracker/product/pages/settings/view/settings_view.dart';
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

  await EasyLocalization.ensureInitialized();

  DateTime now = DateTime.now();

  await SharedPrefInstance
      .init(); // if app terminated, shared pref wont initialize.
  SettingsModel settingsModel = SharedPref().getSavedSettingsModel();

  //Getting wake up and sleeping times from settings model.
  DateTime wakeUpTime = DateTime(now.year, now.month, now.day,
      settingsModel.wakeUpHour, settingsModel.wakeUpMinute);
  DateTime sleepTime = DateTime(now.year, now.month, now.day,
      settingsModel.sleepHour, settingsModel.sleepMinute);

  //How many times receive notification in a day.
  int countOfNotif = settingsModel.notificationCountInADay;

  //Calculating user how many minutes awake in a day. This will be use for calculating interval time between 2 notification.
  int awakeMinutes = (sleepTime.difference(wakeUpTime).inMinutes).abs();

  //Calculating interval minutes between 2 notification.
  int intervalMinute = (awakeMinutes ~/ countOfNotif);

  //Minutes -> Hour:Minute
  int intervalHour = 0;
  if (intervalMinute >= 60) {
    intervalHour = intervalMinute ~/ 60;
    intervalMinute = intervalMinute % 60;
  }

  //Next notification appear interval time later. So we calculating exectly appear time.
  now = now.add(Duration(minutes: intervalMinute, hours: intervalHour));

  //And now, checking is user awake or sleeping.
  if (settingsModel.isNotificationOn) {
    // Notification preference check.
    //In sleep or awake check. If in sleep, set next notification to wakeup hour + 15minute.
    if (sleepTime.hour >= 0 && sleepTime.hour < 12) {
      //if sleep after midnight.
      if (now.isAfter(sleepTime) && now.isBefore(wakeUpTime)) {
        //SLEEPING
        if (DateTime.now().hour >= 0 && DateTime.now().hour < wakeUpTime.hour) {
          AndroidAlarmManager.oneShotAt(
              wakeUpTime.add(const Duration(minutes: 15)), 0, showNotification);
        } else {
          AndroidAlarmManager.oneShotAt(
              wakeUpTime.add(const Duration(minutes: 15, days: 1)),
              0,
              showNotification);
        }
      } else {
        //AWAKE
        AndroidAlarmManager.oneShot(
            Duration(minutes: (intervalMinute + (intervalHour * 60))),
            0,
            showNotification);
      }
    } else {
      // if sleep before midnight.
      if (now.isBefore(sleepTime) && now.isAfter(wakeUpTime)) {
        //AWAKE
        AndroidAlarmManager.oneShot(
            Duration(minutes: (intervalMinute + (intervalHour * 60))),
            0,
            showNotification);
      } else {
        //SLEEPING
        if (DateTime.now().hour >= 0 && DateTime.now().hour < wakeUpTime.hour) {
          AndroidAlarmManager.oneShotAt(
              wakeUpTime.add(const Duration(minutes: 15)), 0, showNotification);
        } else {
          AndroidAlarmManager.oneShotAt(
              wakeUpTime.add(const Duration(minutes: 15, days: 1)),
              0,
              showNotification);
        }
      }
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

  //For localization.
  await EasyLocalization.ensureInitialized();

  SharedPref sharedPref = SharedPref();
  SettingsModel settingsModel = sharedPref.getSavedSettingsModel();

  //If device android initialize alarm
  if (Platform.isAndroid) {
    AndroidAlarmManager.initialize();
  }

  runApp(
    Provider(
        create: (context) => ThemeStore(),
        child: EasyLocalization(
            supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
            path: 'assets/translations',
            fallbackLocale: settingsModel.language == LanguageKeys.english.name
                ? const Locale('en', 'US')
                : settingsModel.language == LanguageKeys.turkish.name
                    ? const Locale('tr', 'TR')
                    : const Locale('en', 'US'),
            child: const MyApp())),
  );

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
    return Observer(builder: (context) {
      return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: themeStore.themeData,
        initialRoute: Routes.home.name,
        routes: NavigationRoutes().routes,
      );
    });
  }
}
