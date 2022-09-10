

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClicked = BehaviorSubject();

  Future<void> initializa() async {

    tz.initializeTimeZones();
    
    const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('ic_stat_sentiment_satisfied_alt');

    IOSInitializationSettings iosInitializationSettings = 
      IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(settings, onSelectNotification: onSelectNotification);
  }

  Future<NotificationAppLaunchDetails?> getDetails() async {
    return await _localNotificationService.getNotificationAppLaunchDetails();
  }

  Future<NotificationDetails> _notificationDetails() async{
    const AndroidNotificationDetails androidNotificationDetails = 
      AndroidNotificationDetails(
        'channel_id', 'channel_name', 
        channelDescription: 'channel_descripton',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true
      );

      const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

        return const NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  Future<void> showPeriodicallydNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval interval,
    required String payload,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.periodicallyShow(
      id, 
      title, 
      body,
      interval,
      details,
      payload: payload,
      androidAllowWhileIdle: true,
    );
  }

  //Start periodically notification.
  Future<void> startReminderNotificaiton() async {
    //Gonna be use for repeatInterval.
    bool isHourly = SharedPref().getInt(SharedPrefKeys.is_notification_hourly) == 1 ? true : false;
    await showPeriodicallydNotification(
      id: 1, title: 'How do you feel?',
       body: 'Save how do you feel right now for track your mood.', 
       interval: isHourly ? RepeatInterval.hourly : RepeatInterval.daily, payload: 'addMood'
      );
  }

  //Stop periodically notification.
  Future<void> stopReminderNotification() async {
    await cancelNotification(1);
  }
  
  Future<void> cancelNotification(int id) async {
    await _localNotificationService.cancel(id);
  }

  void _onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {
    }

  void onSelectNotification(String? payload) {
    if(payload != null && payload.isNotEmpty){
      onNotificationClicked.add(payload);
    }
  }

}