import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';

class GoBackIconButton extends StatelessWidget {
  const GoBackIconButton({Key? key, required this.isThemeChange}) : super(key: key);

  final bool isThemeChange;

  @override
  Widget build(BuildContext context) {
    return CircularIconButtonLeading(iconButton: CircularIconButton(
            child: Icon(Icons.chevron_left,
             color: ProjectColors.primaryBlack.value()),
            onPressed: () => isThemeChange ? Navigator.pushNamedAndRemoveUntil(context, Routes.home.name, (route) => false) : Navigator.pop(context),
          ));
  }
}