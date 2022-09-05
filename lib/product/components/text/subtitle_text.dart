import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';

class SubTitle extends StatelessWidget {
  final String text;

  const SubTitle({
    Key? key, 
    required this.text,
    EdgeInsets? padding,
    Alignment? alignment,
  }) : 
  padding = padding,
  alignment = alignment,
  super(key: key);

  final EdgeInsets? padding;
  final Alignment? alignment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding != null ? padding! : EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value()),
      child: Align(
        alignment: alignment != null ? alignment! : Alignment.centerLeft, 
        child: Text(text, 
        style: Theme.of(context).textTheme.subtitle1?.copyWith(color: ProjectColors.primaryBlack.value(), fontSize: FontSizes.subHeader.value(), fontWeight: FontWeight.w300,),)),
    );
  }
}