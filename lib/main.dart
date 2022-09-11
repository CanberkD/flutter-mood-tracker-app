import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';
import 'package:flutter_mood_tracker/product/service/awesome_notifications_service.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:flutter_mood_tracker/product/theme/theme.dart';



Future<void> main() async {

  //For sharedPrefInstance
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefInstance.init();

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

  //if(sharedPref.getInt(SharedPrefKeys.is_notification_on) == 1){
//
  //  if(DateTime.now().hour >= sharedPref.getInt(SharedPrefKeys.wakeup_hour)){
  //    if (DateTime.now().minute >= sharedPref.getInt(SharedPrefKeys.wakeup_minute)) {
  //      //Ok user awake.
  //      notificationService.startReminderNotificaiton();
  //    }
  //    else { //User in sleep.
  //    notificationService.stopReminderNotification();
  //    }
  //  }
  //  else { //User in sleep.
  //    notificationService.stopReminderNotification();
  //  }
  //} 
  //else { // Notifications off 
  //  notificationService.stopReminderNotification();
  //}

  runApp(const MyApp());
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