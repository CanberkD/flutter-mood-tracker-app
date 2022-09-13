import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mood_tracker/core/components/basic/bottom_sheet_divider.dart';
import 'package:flutter_mood_tracker/core/components/button/toggle_button.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
import 'package:flutter_mood_tracker/product/components/text/header_text.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';

import '../viewModel/input_viewmodel.dart';

//--------------------------------------------------------------------------------------------------------------------

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required InputViewModel model,
  })  : _model = model,
        super(key: key);

  final InputViewModel _model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: PaddingSizes.mainColumnVerticalPadding.value()),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: ButtonSize.simpleButtonWidth.value(),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ProjectColors.primaryWhite.value()),
                  overlayColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return states.contains(MaterialState.pressed)
                          ? ProjectColors.primaryBlue.value().withOpacity(0.2)
                          : null;
                    },
                  )),
              onPressed: (){_model.saveButtonClicked(context);},
              child: Text('inputpageSaveButtonText'.tr(),
                  style: TextStyle(color: ProjectColors.primaryBlack.value())).tr(),
            ),
          ),
        ),
      ),
    );
  }
}

class PeopleSelectionTitle extends StatelessWidget {
  const PeopleSelectionTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: PaddingSizes.mainColumnVerticalPadding.value(),
          bottom: PaddingSizes.small.value()),
      child: SubTitle(text: 'inputpagePeopleSelectionTitle'.tr()),
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
      child: SubTitle(text: 'inputpageActivitySelectionTitle'.tr()),
    );
  }
}

class MoodSelectionWidget extends StatelessWidget {
  const MoodSelectionWidget({
    Key? key,
    required InputViewModel model,
  })  : _model = model,
        super(key: key);

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
      padding:
          EdgeInsets.only(top: PaddingSizes.mainColumnVerticalPadding.value()),
      child: SubTitle(text: 'inputpageMoodSelectionTitle'.tr()),
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
      child: HeaderTextWidget(text: 'inputpageTitleChoose'.tr()),
    );
  }
}

class ButtonClose extends StatelessWidget {
  const ButtonClose({
    Key? key,
    required this.model,
  }) : super(key: key);

  final InputViewModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: PaddingSizes.mainColumHorizontalPadding.value(),
      ),  
      child: CircularIconButton(
          onPressed: () {model.pageCloseButtonPressed(context);},
          child: Padding(
            padding:
                EdgeInsets.all(PaddingSizes.iconButtonChildPadding.value()*2),
            child: Image.asset(PngPaths(themeInfo: ThemeInfo.dark).close),
          )),
    );
  }
}

//--------------------------------------------------------------------------------------------------------------------

//********************************************************************************************************************
class PeopleSelection extends StatelessWidget {
  const PeopleSelection({
    Key? key,
    required InputViewModel model,
  })  : _model = model,
        super(key: key);

  final InputViewModel _model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: InputViewConsts.activitySelectionButtonHeight * 1.5,
      child: Observer(builder: (_) {
        return ListView.builder(
          controller: _model.peopleScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: _model.peopleList.length + 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: index == 0
                  ? EdgeInsets.symmetric(
                      horizontal:
                          PaddingSizes.mainColumHorizontalPadding.value())
                  : EdgeInsets.only(right: PaddingSizes.medium.value()),
              child: index != _model.peopleList.length
                  ? ToggleButton(
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
                        child: Text(_model.peopleList[index],
                            style: TextStyle(
                                color: ProjectColors.primaryBlack.value())),
                      ),
                      selectedChild: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(_model.peopleList[index],
                            style: TextStyle(
                                color: ProjectColors.primaryWhite.value())),
                      ),
                      isSelected: _model.isPeoplesBoolList[index],
                    )
                  : CircularAddButton(model: _model, isActivity: false),
            );
          },
        );
      }),
    );
  }
}

class MoodSelectionGroup extends StatelessWidget {
  const MoodSelectionGroup({
    Key? key,
    required InputViewModel model,
  })  : _model = model,
        super(key: key);

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
      isSelectedBoolList: [
        _model.isButtonSelectedList[0],
        _model.isButtonSelectedList[1],
        _model.isButtonSelectedList[2]
      ],
      onPressed: (List<bool> boolList) {
        _model.isButtonSelectedList = boolList;
      },
    );
  }
}

class ActivitySelectionGroup extends StatelessWidget {
  const ActivitySelectionGroup({
    Key? key,
    required InputViewModel model,
  })  : _model = model,
        super(key: key);

  final InputViewModel _model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: InputViewConsts.activitySelectionButtonHeight * 1.5,
      child: Observer(builder: (_) {
        return ListView.builder(
          controller: _model.activityScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: _model.activityList.length + 1,
          itemBuilder: (context, index) {
            return Observer(builder: (_) {
              return Padding(
                padding: index == 0
                    ? EdgeInsets.symmetric(
                        horizontal:
                            PaddingSizes.mainColumHorizontalPadding.value())
                    : EdgeInsets.only(right: PaddingSizes.medium.value()),
                child: index != _model.activityList.length
                    ? ToggleButton(
                        borderRadius:
                            InputViewConsts.peopleSelectionBorderRadius,
                        width: InputViewConsts.activitySelectionButtonWidth,
                        heigth: InputViewConsts.activitySelectionButtonHeight,
                        onpressed: (isSelected) {
                          _model.resetActivityBoolList();
                          _model.isActivityBoolList[index] = isSelected;
                        },
                        notSelectedColor: ProjectColors.primaryWhite.value(),
                        selectedColor: ProjectColors.primaryBlue.value(),
                        notSelectedChild: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(_model.activityList[index],
                              style: TextStyle(
                                  color: ProjectColors.primaryBlack.value())),
                        ),
                        selectedChild: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(_model.activityList[index],
                              style: TextStyle(
                                  color: ProjectColors.primaryWhite.value())),
                        ),
                        isSelected: _model.isActivityBoolList[index],
                      )
                    : CircularAddButton(model: _model, isActivity: true),
              );
            });
          },
        );
      }),
    );
  }
}

class CircularAddButton extends StatelessWidget {
  const CircularAddButton({
    Key? key,
    required this.model,
    required this.isActivity,
  }) : super(key: key);

  final bool isActivity; // activity or peoples
  final InputViewModel model;

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      bgColor: ProjectColors.primaryWhite.value(),
      onPressed: () {
        isActivity
            ? model.activityAddButtonClicked(context)
            : model.peopleAddButtonClicked(context);
      },
      child: Padding(
        padding: EdgeInsets.all(PaddingSizes.iconButtonChildPadding.value()),
        child: Image.asset(PngPaths(themeInfo: ThemeInfo.dark).plus),
      ),
    );
  }
}

class AddItemWidget extends StatelessWidget {
  AddItemWidget(
      {Key? key, required this.isActivity, required this.onAddPressed})
      : super(key: key);

  final bool isActivity;
  final Function(String text) onAddPressed;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: PaddingSizes.large.value()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BottomSheetTopLine(),
            SubTitle(
                padding: EdgeInsets.only(top: PaddingSizes.small.value()),
                alignment: Alignment.center,
                text: isActivity ? 'addctivity'.tr() : 'addperson'.tr()),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          onFieldSubmitted: (value) {
                            if (_controller.text.length >= 3) {
                                  onAddPressed.call(_controller.text);
                                }
                          },
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: isActivity ? 'activity'.tr() : 'name'.tr(),
                              counterText: ''),
                          maxLength: 12,
                          controller: _controller,
                          autofocus: true,

                        ),
                        SizedBox(
                          width: ButtonSize.simpleButtonWidth.value(),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_controller.text.length >= 3) {
                                  onAddPressed.call(_controller.text);
                                }
                              },
                              child: Text('add'.tr())),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
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
