import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:flutter_mood_tracker/product/theme/theme.dart';

Future<void> main() async {

  //For sharedPrefInstance
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefInstance.init();

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
