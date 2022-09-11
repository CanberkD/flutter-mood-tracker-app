
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';
import 'package:flutter_mood_tracker/product/pages/settings/model/settings_model.dart';
import 'package:flutter_mood_tracker/product/service/awesome_notifications_service.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:flutter_mood_tracker/product/theme/theme.dart';

void showNotification(){
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
  int intervalMinute = ((wakeUpHours*60)~/countOfNotif);
  int intervalHour = 0;
  if(intervalMinute >= 60){
      intervalHour = intervalMinute~/60;
      intervalMinute = intervalMinute%60;
  }
  
  intervalHour = 0;
  intervalMinute = 1;
    if(settingsModel.isNotificationOn){
      if(dateTime.hour + intervalHour >= settingsModel.wakeUpHour && dateTime.hour + intervalHour < settingsModel.sleepHour){
        AndroidAlarmManager.oneShot(Duration(minutes: (intervalMinute + (intervalHour*60))), alarmId, showNotification);
      }
      else {
        AndroidAlarmManager.oneShot(Duration(minutes: ((settingsModel.wakeUpHour - dateTime.hour)*60) + 60), alarmId, showNotification);
      }
    }
}

Future<void> main() async {

  //For sharedPrefInstance.
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefInstance.init();

    //For background running
  //const androidConfig = FlutterBackgroundAndroidConfig(
  //    notificationTitle: "Mood Tracker Running",
  //    notificationText: "We running app in background for sending reminder notification.",
  //    notificationImportance: AndroidNotificationImportance.Default,
  //    notificationIcon: AndroidResource(name: 'ic_stat_sentiment_satisfied_alt', defType: 'drawable'),
  //);
  //await FlutterBackground.initialize(androidConfig: androidConfig);
  //await FlutterBackground.enableBackgroundExecution();


  //Notification service initializing.
  AwesomeNotificationService().initialize([
    NotificationChannel(
      channelKey: ChannelKeys.moodReminder.name, 
      channelName: 'Mood reminder', 
      channelDescription: 'Notification of this channel reminds you input your mood.',
      importance: NotificationImportance.High,
      channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: ChannelKeys.notificationOn.name, 
        channelName: 'Notification on', 
        channelDescription: 'We will send notification through this channel when you set notification on.',
        importance: NotificationImportance.High,
        channelShowBadge: false
      )
  ]);


  await AndroidAlarmManager.initialize();
  runApp(const MyApp());

  //const int helloAlarmID = 0;
  //SharedPref sharedPref = SharedPref();
  //SettingsModel settingsModel = sharedPref.getSavedSettingsModel();
  //int countOfNotif = settingsModel.notificationCountInADay;
  //int wakeUpHours = settingsModel.sleepHour - settingsModel.wakeUpHour;
  //int intervalMinute = ((wakeUpHours*60)~/countOfNotif);
  //
  //AndroidAlarmManager.periodic(Duration(minutes: intervalMinute), helloAlarmID, showNotification);

  nextAlarmSetup();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',  
      theme: CustomThemeData.light(),
      initialRoute: Routes.home.name,
      routes: NavigationRoutes().routes,
    );
  }
}