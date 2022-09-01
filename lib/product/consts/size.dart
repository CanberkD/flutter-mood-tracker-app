import 'package:flutter/cupertino.dart';

enum ButtonSize {iconbuttonsize,}

extension ButtonSizeExtension on ButtonSize{
  double value(){
    switch(this){
      case ButtonSize.iconbuttonsize:
        return 40.0;
      
    }
  }
}

enum PaddingSizes {small, medium, large, mainColumnVerticalPadding, mainColumHorizontalPadding, iconButtonChildPadding}

extension PaddingSizeExtension on PaddingSizes {
  double value(){
    switch(this){
      case PaddingSizes.mainColumHorizontalPadding:
        return 24.0;
      case PaddingSizes.iconButtonChildPadding:
        return 52.0;
      case PaddingSizes.small:
        return 8.0;
      case PaddingSizes.medium:
        return 16.0;
      case PaddingSizes.large:
        return 32.0;
      case PaddingSizes.mainColumnVerticalPadding:
        return 48.0;
    }
  }
}

enum FontSizes {header, subHeader}

extension FontSizesExtension on FontSizes{
  double value(){
    switch(this){
      case FontSizes.header:
        return 52.0;
      case FontSizes.subHeader:
        return 22.0;
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
