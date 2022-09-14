//***************************************************************************************
//
//THIS COMPONENT COPY OF https://pub.dev/packages/introduction_slider with some edits
// 
//***************************************************************************************


import 'package:flutter/material.dart';

class DotIndicator {
  /// The size of the dot.
  final double? size;

  /// The selected color of the dot.
  final Color? selectedColor;

  /// The unselected color of the dot.
  final Color? unselectedColor;

  const DotIndicator({
    this.size = 10,
    this.selectedColor = Colors.blue,
    this.unselectedColor,
  });
}
