import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/consts/text.dart';
import './widgets.dart';
import 'package:flutter_mood_tracker/product/home/viewmodel/homepage_viewmodel.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  final HomePageViewModel _model = HomePageViewModel();               
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(right: PaddingSizes.mainColumHorizontalPadding.value(), top: PaddingSizes.mainColumHorizontalPadding.value()),
                child: settingButton(),
              ),
              Padding(
                padding: EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value()),
                child: HelloBar(model: _model),
              ),
              Padding(
                padding: EdgeInsets.only(top: PaddingSizes.mainColumnVerticalPadding.value(), bottom: PaddingSizes.mainColumnVerticalPadding.value()),
                child: TodayBar(model: _model),
              ),
              const SubTitle(text: ProjectText.homepageSubtitleInfogram),
              _model.infogramList.isNotEmpty ? Infogram(model: _model,) : const InformationText(text: ProjectText.informationEmptyInfogram),
              RecordedTopBar(model: _model),
              _model.recordedList.isNotEmpty ? RecordedList(model: _model) : const InformationText(text: ProjectText.informationEmptyRecorded),
            ],
          ),
        ),
    );
  }

  Align settingButton() {
    return Align(
              alignment: Alignment.centerRight,
              child: CircularIconButton(onPressed: () {}, child: Padding(
                padding: EdgeInsets.all(PaddingSizes.iconButtonChildPadding.value()),
                child: Image.asset(_model.pngPaths.setting),
              )));
  }
}

class InformationText extends StatelessWidget {
  const InformationText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: PaddingSizes.mainColumHorizontalPadding.value()) + EdgeInsets.only(top: PaddingSizes.small.value()),
      child: Text(text),
    );
  }
}

//Constants
class HomePageViewConsts {
  static double todayCardIconSize = 32.0;
  static double todayCardSize = 100;
  static double infogramContainerSize = 130;
  static double recordedCardHeight = 100;
  static double infogramCardWidth = 300;
}