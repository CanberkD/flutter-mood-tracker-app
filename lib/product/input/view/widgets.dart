
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/core/components/button/toggle_button.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
import 'package:flutter_mood_tracker/product/components/text/header_text.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/consts/text.dart';

import '../viewModel/input_viewmodel.dart';


//--------------------------------------------------------------------------------------------------------------------

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required InputViewModel model,
  }) : _model = model, super(key: key);

  final InputViewModel _model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: InputViewConsts.saveButtonPadding, vertical: PaddingSizes.mainColumnVerticalPadding.value()),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ProjectColors.primaryWhite.value()),
          overlayColor: MaterialStateProperty.resolveWith(
                (states) {
                  return states.contains(MaterialState.pressed)
                      ? ProjectColors.primaryBlue.value().withOpacity(0.2)
                      : null;
                },
              )),
        onPressed: _model.saveButtonClicked,
        child: Text(ProjectText.inputpageSaveButtonText, style: TextStyle(color: ProjectColors.primaryBlack.value())),
    ));
  }
}

class PeopleSelectionTitle extends StatelessWidget {
  const PeopleSelectionTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: PaddingSizes.mainColumnVerticalPadding.value(), bottom: PaddingSizes.small.value()),
      child: const SubTitle(text: ProjectText.inputpagePeopleSelectionTitle),  
    );
  }
}

class ActivitySelectionTitle extends StatelessWidget {
  const ActivitySelectionTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: PaddingSizes.mainColumnVerticalPadding.value(),
          bottom: PaddingSizes.small.value(),
          ),
      child: const SubTitle(text: ProjectText.inputpageActivitySelectionTitle),
    );
  }
}

class MoodSelectionWidget extends StatelessWidget {
  const MoodSelectionWidget({
    Key? key,
    required InputViewModel model,
  }) : _model = model, super(key: key);

  final InputViewModel _model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: PaddingSizes.mainColumHorizontalPadding.value()),
      child: MoodSelectionGroup(model: _model),
    );
  }
}

class MoodSelectionTitle extends StatelessWidget {
  const MoodSelectionTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: PaddingSizes.mainColumnVerticalPadding.value()),
      child: const SubTitle(text: ProjectText.inputpageMoodSelectionTitle),
    );
  }
}

class MainHeader extends StatelessWidget {
  const MainHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: PaddingSizes.mainColumHorizontalPadding.value()),
      child:
          const HeaderTextWidget(text: ProjectText.inputpageTitleChoose),
    );
  }
}

class ButtonClose extends StatelessWidget {
  const ButtonClose({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

//--------------------------------------------------------------------------------------------------------------------

//********************************************************************************************************************
class PeopleSelection extends StatelessWidget {
  const PeopleSelection({
    Key? key,
    required InputViewModel model,
  }) : _model = model, super(key: key);

  final InputViewModel _model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: InputViewConsts.activitySelectionButtonHeight*1.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _model.peoplesList.length + 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: index == 0 ? 
            EdgeInsets.symmetric(horizontal: PaddingSizes.mainColumHorizontalPadding.value()) :
            EdgeInsets.only(right: PaddingSizes.medium.value()) ,
            child: index != _model.peoplesList.length? 
             ToggleButton(
              borderRadius: InputViewConsts.peopleSelectionBorderRadius,
              width: InputViewConsts.activitySelectionButtonWidth,
              heigth: InputViewConsts.activitySelectionButtonHeight,
              onpressed: (isSelected) {
                _model.isPeoplesBoolList[index] = isSelected;
              }, 
              notSelectedColor: ProjectColors.primaryWhite.value(), 
              selectedColor: ProjectColors.primaryBlue.value(), 
              notSelectedChild: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(_model.peoplesList[index], style: TextStyle(color: ProjectColors.primaryBlack.value())),
              ), 
              selectedChild: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(_model.peoplesList[index], style: TextStyle(color: ProjectColors.primaryWhite.value())),
              ), 
              isSelected: _model.isPeoplesBoolList[index],
            ): 
            CircularAddButton(model: _model, isActivity: false)
            ,
          );
        },
      ),
    );
  }
}

class MoodSelectionGroup extends StatelessWidget {
  const MoodSelectionGroup({
    Key? key,
    required InputViewModel model,
  }) : _model = model, super(key: key);

  final InputViewModel _model;

  @override
  Widget build(BuildContext context) {
    return ToggleGroup(
            buttonWidth: InputViewConsts.moodSelectionButtonWidth,
            buttonHeight: InputViewConsts.moodSelectionButtonHeight,
            borderRadius: InputViewConsts.moodSelectionButtonRadius,
            selectedChildList: _model.selectedMoodWidgets,
            notSelectedChildList: _model.notSelectedMoodWidgets,
            selectedColor: ProjectColors.primaryBlue.value(), 
            notSelectedColor: ProjectColors.primaryWhite.value(), 
            isSelectedBoolList: [_model.isButtonSelectedList[0], _model.isButtonSelectedList[1], _model.isButtonSelectedList[2]],
            onPressed: (List<bool> boolList) { 

             },
            );
  }
}

class ActivitySelectionGroup extends StatelessWidget {
  const ActivitySelectionGroup({
    Key? key,
    required InputViewModel model,
  }) : _model = model, super(key: key);

  final InputViewModel _model;

  @override
  Widget build(BuildContext context) {
    return ToggleGroup(
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      toggleButtonPadding: EdgeInsets.only(right: PaddingSizes.mainColumHorizontalPadding.value()),
      firstChildButtonPadding:  EdgeInsets.only(
        right: PaddingSizes.mainColumHorizontalPadding.value(), 
        left: PaddingSizes.mainColumHorizontalPadding.value()
      ),
      alignment: AxisAlignment.none,
      buttonWidth: InputViewConsts.activitySelectionButtonWidth,
      buttonHeight: InputViewConsts.activitySelectionButtonHeight,
      selectedChildList: _model.activtyChildWidgetsSelected,
      notSelectedChildList: _model.activtyChildWidgetsNotSelected,
      selectedColor: ProjectColors.primaryBlue.value(), 
      notSelectedColor: ProjectColors.primaryWhite.value(), 
      isSelectedBoolList: _model.activityBoolList,
      lastWidget: SizedBox(
        width: ButtonSize.iconbuttonsize.value(),
        height: ButtonSize.iconbuttonsize.value(),
        child: CircularAddButton(model: _model, isActivity: true)
      ),
      onPressed: (List<bool> boolList) { 

       },
    );
  }
}

class CircularAddButton extends StatelessWidget {

  const CircularAddButton({
    Key? key, required  this.model, required this.isActivity,
  }) : super(key: key);

  final bool isActivity; // activity or peoples
  final InputViewModel model;

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      bgColor: ProjectColors.primaryWhite.value(),
      onPressed: () { 
        
      },
    child: Padding(
      padding: EdgeInsets.all(PaddingSizes.iconButtonChildPadding.value()),
      child: Image.asset(PngPaths(themeInfo: ThemeInfo.dark).plus),
    ),
    );
  }
}

//********************************************************************************************************************


class InputViewConsts {
  static double activitySelectionButtonHeight = 30;
  static double activitySelectionButtonWidth = 100;

  static double moodSelectionButtonWidth = 100;
  static double moodSelectionButtonHeight = 100;
  static double moodSelectionButtonRadius = 10;

  static double peopleSelectionBorderRadius = 25.0;

  static double saveButtonPadding = 140; 
}
