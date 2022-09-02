import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/core/components/button/toggle_button.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
import 'package:flutter_mood_tracker/product/components/text/header_text.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/consts/text.dart';
import 'package:flutter_mood_tracker/product/input/viewModel/input_viewmodel.dart';

class InputView extends StatefulWidget {
  const InputView({Key? key}) : super(key: key);
  @override
  State<InputView> createState() => _InputViewState();
}

class _InputViewState extends State<InputView> {
  final InputViewModel _model = InputViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: PaddingSizes.mainColumHorizontalPadding.value(),
                top: PaddingSizes.mainColumnVerticalPadding.value()),
            child: Align(
              alignment: Alignment.centerRight,
              child: CircularIconButton(
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.all(
                        PaddingSizes.iconButtonChildPadding.value()),
                    child:
                        Image.asset(PngPaths(themeInfo: ThemeInfo.dark).close),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: PaddingSizes.mainColumHorizontalPadding.value()),
            child:
                const HeaderTextWidget(text: ProjectText.inputpageTitleChoose),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: PaddingSizes.mainColumnVerticalPadding.value()),
            child: const SubTitle(text: 'How doy you feel?'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: PaddingSizes.mainColumHorizontalPadding.value()),
            child: moodButtonGroup(),
          ),
        ],
      ),
    );
  }

  ToggleGroup moodButtonGroup() {
    return ToggleGroup(
            buttonWidth: 100,
            buttonHeight: 100,
            selectedChildList: [Image.asset(PngPaths(themeInfo: ThemeInfo.light).happy), Image.asset(PngPaths(themeInfo: ThemeInfo.light).notr),Image.asset(PngPaths(themeInfo: ThemeInfo.light).sad)], 
            notSelectedChildList: [Image.asset(PngPaths(themeInfo: ThemeInfo.dark).happy), Image.asset(PngPaths(themeInfo: ThemeInfo.dark).notr),Image.asset(PngPaths(themeInfo: ThemeInfo.dark).sad)], 
            selectedColor: ProjectColors.primaryBlue.value(), 
            notSelectedColor: ProjectColors.primaryWhite.value(), 
            isSelectedBoolList: [_model.isButtonSelectedList[0], _model.isButtonSelectedList[1], _model.isButtonSelectedList[2]],
            onPressed: (List<bool> boolList) { 
              print(boolList);
             },
            );
  }

}
