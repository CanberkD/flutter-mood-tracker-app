


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/go_back_button.dart';
import 'package:flutter_mood_tracker/product/components/text/header_text.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/pages/settings/view/widgets.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  SharedPref sharedPref = SharedPref();

  bool isThemeChange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GoBackIconButton(isThemeChange: isThemeChange),
        ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value()),
            child: Align(alignment: Alignment.centerLeft, child: HeaderTextWidget(text: 'settings'.tr())),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: PaddingSizes.mainColumnVerticalPadding.value()),
              child: ListView(
                children: [
                  const WakeupTime(),
                  const Divider(height: 1),
                  const SleepTime(),
                  const Divider(height: 1),
                  NotificationMain(sharedPref: sharedPref),
                  const Divider(height: 1),
                  Language(sharedPref: sharedPref),
                  const Divider(height: 1),
                  MenuTheme(sharedPref: sharedPref, onPressed: () {setState(() {isThemeChange = !isThemeChange;});
                  }),
                ],
              ),
            ),
          )
        ],
      ),
      );
  }
}
