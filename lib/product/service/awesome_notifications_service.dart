import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/pages/input/view/input_view.dart';
import 'package:flutter_mood_tracker/product/pages/settings/model/settings_model.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';

class AwesomeNotificationService {

  //Initialize method.
  void initialize(List<NotificationChannel> notificationChannelList){
    AwesomeNotifications().initialize(
    'resource://drawable/ic_stat_sentiment_satisfied_alt', 
    notificationChannelList
    );
    
  }

  //Simple notification creator.
  Future<void> simpleNotificationNotificationOn() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          wakeUpScreen: false,
          id: ChannelIds.notificationOn.index,
          channelKey: ChannelKeys.notificationOn.name,
          title: 'notificationon'.tr(),
          body: 'remindernotificationon'.tr(),
          notificationLayout: NotificationLayout.Default),
    );
  }

    Future<void> simpleNotificationForReminder() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          wakeUpScreen: true,
          id: ChannelIds.moodReminder.index,
          channelKey: ChannelKeys.moodReminder.name,
          title: 'How do you feel?',
          body: 'Save your feels for track mood changes in your day.',
          notificationLayout: NotificationLayout.Default),
    );
  }

void showNotification(){
    AwesomeNotifications().cancelAll;
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
                minutes:
                    ((settingsModel.wakeUpHour - dateTime.hour) * 60) + 60),
            alarmId,
            showNotification);
      }
    }
  }

  ////Scheduled notification creator.
  //Future<void> scheduledNotification(ChannelIds id, ChannelKeys key, int hour, int minute) async { 
//
  //  await AwesomeNotifications().createNotification(
  //    content: NotificationContent(
  //      id: id.index,
  //      wakeUpScreen: true,
  //      channelKey: key.name,
  //      title: 'How do you feel?',
  //      body: 'Save your feels for track mood changes in your day.',  
  //      notificationLayout: NotificationLayout.Default,
  //    ),
  //    schedule: NotificationCalendar(
  //      hour: hour,
  //      minute: minute,
  //      timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
  //    )
  //  );
  //}
//

  //Listeners.  
  void awesomeNotificationAddMoodListener(BuildContext context, ChannelIds id){

    AwesomeNotifications().actionStream.listen((event) {
      if(Platform.isIOS){
        AwesomeNotifications().getGlobalBadgeCounter().then((value) => {
          AwesomeNotifications()
        });
      }
      if(event.id == id.index){
        //When notification click, first page gonna be mood input page. 
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const InputView(),), (route) => false);
      }
    });

    //TODO: Check it later for notifications.
    //When notification display, next one schedule now.
    //AwesomeNotifications().displayedStream.listen((event) { 
    //  if(event.id == id.index){
    //    setNextNotification();
    //  }
    //});

}

  //void setNextNotification(){
  //  SharedPref sharedPref = SharedPref();
  //  SettingsModel settingsModel = sharedPref.getSavedSettingsModel();
  //  DateTime dateTime = DateTime.now();
//
  //  int countOfNotif = settingsModel.notificationCountInADay;
  //  int wakeUpHours = settingsModel.sleepHour - settingsModel.wakeUpHour;
  //  int intervalHour = 0;
  //  int intervalMinute = ((wakeUpHours*60)~/countOfNotif);
  //  if(intervalMinute >= 60){
  //    intervalHour = intervalMinute~/60;
  //    intervalMinute = intervalMinute%60;
  //  }
//
  //  if(settingsModel.isNotificationOn){ //Notification settings check
  //    if (dateTime.hour + intervalHour>= settingsModel.wakeUpHour && dateTime.hour + intervalHour < settingsModel.sleepHour) { //is wake hour
  //      if (dateTime.minute + intervalMinute > settingsModel.wakeUpMinute) { // is wake minutes of hour.
  //        if((dateTime.minute + intervalMinute)> 60){  //is next minute > 60
  //          intervalHour = (dateTime.minute + intervalMinute)~/60; //add 60+ to intervalHour + 1;
  //          intervalMinute = 60-intervalMinute; // left goes to minutes.
  //        }
  //        scheduledNotification(ChannelIds.moodReminder, ChannelKeys.moodReminder, dateTime.hour + intervalHour, dateTime.minute + intervalMinute);
  //      }
  //      else {
  //        scheduledNotification(ChannelIds.moodReminder, ChannelKeys.moodReminder, settingsModel.wakeUpHour , settingsModel.wakeUpMinute + 15);
  //      }
  //    }
  //    else {
  //        scheduledNotification(ChannelIds.moodReminder, ChannelKeys.moodReminder, settingsModel.wakeUpHour , settingsModel.wakeUpMinute + 15);
  //    }
  //  }
//
  //}

  //Permission control method.
  void awesomeNotificationsPermissionCheck(BuildContext context){
    //
    AwesomeNotifications().isNotificationAllowed().then((value) => {
      if(!value){
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('allownotifications'.tr()),
          content: Text('notificationpermisson'.tr()),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            },
            child: Text('dontallow'.tr())),
            ElevatedButton(onPressed: () => AwesomeNotifications().requestPermissionToSendNotifications().then((value) => Navigator.pop(context)),
            child: Text('allow'.tr()),
            )
          ],  
          )
        )
      }
    }
    );
  }

}

enum ChannelIds {moodReminder, notificationOn}
enum ChannelKeys {moodReminder, notificationOn}