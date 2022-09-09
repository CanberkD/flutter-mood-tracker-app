import 'package:flutter/cupertino.dart';

enum ButtonSize {iconbuttonsize, simpleButtonWidth}

extension ButtonSizeExtension on ButtonSize{
  double value(){
    switch(this){
      case ButtonSize.iconbuttonsize:
        return 30.0;
      case ButtonSize.simpleButtonWidth:
        return 150;
    }
  }
}

enum PaddingSizes {small, medium, large, mainColumnVerticalPadding, mainColumHorizontalPadding, iconButtonChildPadding, toggleButtonChildPadding}

extension PaddingSizeExtension on PaddingSizes {
  double value(){
    switch(this){
      case PaddingSizes.mainColumHorizontalPadding:
        return 24.0;
      case PaddingSizes.iconButtonChildPadding:
        return 64.0;
      case PaddingSizes.small:
        return 8.0;
      case PaddingSizes.medium:
        return 16.0;
      case PaddingSizes.large:
        return 32.0;
      case PaddingSizes.mainColumnVerticalPadding:
        return 28.0;
      case PaddingSizes.toggleButtonChildPadding:
        return 256.0;
    }
  }
}

enum FontSizes {header, subHeader}

extension FontSizesExtension on FontSizes{
  double value(){
    switch(this){
      case FontSizes.header:
        return 44.0;
      case FontSizes.subHeader:
        return 23.0;
    }
  }
}

enum FontWeights { header }

extension FontWeightsExtension on FontWeights {
  FontWeight value() {
    switch (this) {
      case FontWeights.header:
        return FontWeight.w400;
    }
  }
}

enum RoundSizes {showModelMainSize}
extension RoundSizesExtension on RoundSizes {
  double value(){
    switch(this){
      case RoundSizes.showModelMainSize:
        return 25.0;
    }
  }
}

enum ImageSizes {recordedDayListTileMoodImageSize}

extension ImageSizesExtension on ImageSizes {
  double value(){
    switch(this){
      case ImageSizes.recordedDayListTileMoodImageSize:
        return 64.0;
    }
  }
}