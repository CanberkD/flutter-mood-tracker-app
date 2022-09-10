import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';

class GoBackIconButton extends StatelessWidget {
  const GoBackIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularIconButtonLeading(iconButton: CircularIconButton(
            child: Icon(Icons.chevron_left,
             color: ProjectColors.primaryBlack.value()),
            onPressed: () => Navigator.pop(context),
          ));
  }
}