import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';


class CircularIconButton extends StatelessWidget {

  const CircularIconButton({
    Key? key,
    required this.child,
    required this.onPressed,
    Color? bgColor,
    }): 
    bgColor = bgColor ?? Colors.grey,
    super(key: key);

  final Widget child;
  final void Function() onPressed;
  final Color bgColor;

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
          primary: bgColor),
        child: FittedBox(fit: BoxFit.fitHeight,child: child),
      )
      );
  }
}

class CircularIconButtonLeading extends StatelessWidget {
  const CircularIconButtonLeading({
    Key? key,
    required this.iconButton,
  }) : super(key: key);

  final CircularIconButton iconButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(13),
          child: iconButton,
        );
  }
}

