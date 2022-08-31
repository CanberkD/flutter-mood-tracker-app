import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';


class CircularIconButton extends StatelessWidget {

  const CircularIconButton({
    Key? key,
    required this.child,
    required this.onPressed,
    }) : super(key: key);

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ButtonSize.iconbuttonsize.value(),
      height: ButtonSize.iconbuttonsize.value(),
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(), 
          padding: EdgeInsets.zero,
          primary:ProjectColors.primaryGrey.value()),
        child: FittedBox(fit: BoxFit.fitHeight,child: child),
      )
      );
  }
}