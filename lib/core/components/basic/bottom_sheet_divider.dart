import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';

class BottomSheetTopLine extends StatelessWidget {
  const BottomSheetTopLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, 
      child:SizedBox(width: 40, child: Divider(thickness: 3.0, color: ProjectColors.primaryGrey.value()))
    );
  }
}