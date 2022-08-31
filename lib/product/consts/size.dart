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

enum PaddingSizes {small, mainColumnPadding, iconButtonChildPadding}

extension PaddingSizeExtension on PaddingSizes {
  double value(){
    switch(this){
      case PaddingSizes.mainColumnPadding:
        return 24.0;
      case PaddingSizes.iconButtonChildPadding:
        return 52.0;
      case PaddingSizes.small:
        return 8.0;
    }
  }
}

enum FontSizes {header}

extension FontSizesExtension on FontSizes{
  double value(){
    switch(this){
      case FontSizes.header:
        return 52.0;
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
