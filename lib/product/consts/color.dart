import 'package:flutter/material.dart';

enum ProjectColors {primaryBlue, primaryGrey, primaryWhite, primaryBlack}

extension ColorsExtension on ProjectColors{
  Color value(){
    switch(this){
      case ProjectColors.primaryBlue:
        return const Color(0xff1188B5);
      case ProjectColors.primaryGrey:
        return const Color.fromRGBO(183, 183, 183, 1.0);
      case ProjectColors.primaryWhite:
        return const Color(0xffF5F5F5);
      case ProjectColors.primaryBlack:
        return const Color(0xff1C1D21);
    }
  }
}