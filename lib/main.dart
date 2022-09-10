import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';
import 'package:flutter_mood_tracker/product/pages/input/view/input_view.dart';
import 'package:flutter_mood_tracker/product/service/notification_service.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:flutter_mood_tracker/product/theme/theme.dart';



Future<void> main() async {

  //For sharedPrefInstance
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefInstance.init();

  NotificationService notificationService = NotificationService();
  SharedPref sharedPref = SharedPref();

  if(sharedPref.getInt(SharedPrefKeys.is_notification_on) == 1){

    if(DateTime.now().hour >= sharedPref.getInt(SharedPrefKeys.wakeup_hour)){
      if (DateTime.now().minute >= sharedPref.getInt(SharedPrefKeys.wakeup_minute)) {
        //Ok user awake.
        notificationService.startReminderNotificaiton();
      }
      else { //User in sleep.
      notificationService.stopReminderNotification();
      }
    }
    else { //User in sleep.
      notificationService.stopReminderNotification();
    }
  } 
  else { // Notifications off 
    notificationService.stopReminderNotification();
  }

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

class MyWidget extends StatefulWidget {

  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late final NotificationService notificationService; 

  @override
  void initState() {
    super.initState();
    notificationService = NotificationService();
    listToNotification();
    notificationService.initializa();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  void listToNotification() => notificationService.onNotificationClicked.stream.listen((onNotificationListener));

  void onNotificationListener(String? payload){
    if(payload != null && payload.isNotEmpty){
      print('payload $payload');
      Navigator.push(context, MaterialPageRoute(builder: (context) => const InputView(),));
    }
  }
}