import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/consts/text.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';
import './widgets.dart';
import 'package:flutter_mood_tracker/product/pages/home/viewmodel/homepage_viewmodel.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  final HomePageViewModel _model = HomePageViewModel();           
  
  @override
  void initState() {
    super.initState();
    _model.notificationSetup(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [settingButton()],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value()),
                  child: HelloBar(model: _model),
                ),
                Padding(
                  padding: EdgeInsets.only(top: PaddingSizes.mainColumnVerticalPadding.value(), bottom: PaddingSizes.mainColumnVerticalPadding.value()),
                  child: TodayBar(model: _model, context: context),
                ),
                const SubTitle(text: ProjectText.homepageSubtitleInfogram),
                _model.infogramList.isNotEmpty ? Infogram(model: _model,) : const InformationText(text: ProjectText.informationEmptyInfogram),
                Padding(
                  padding: EdgeInsets.zero,
                  child: RecordedTopBar(model: _model),
                ),
                _model.recordedList.isNotEmpty ? RecordedList(model: _model) : const InformationText(text: ProjectText.informationEmptyRecorded),
              ],
            ),
        ),
        ),
    );

  }

  Padding settingButton() {
    return Padding(
      padding: EdgeInsets.only(right: PaddingSizes.mainColumHorizontalPadding.value()),
      child: Align(
                alignment: Alignment.centerRight,
                child: CircularIconButton(onPressed: ()  => Navigator.pushNamed(context, Routes.settings.name), 
                  child: Padding(
                  padding: EdgeInsets.all(PaddingSizes.iconButtonChildPadding.value()),
                  child: Image.asset(_model.pngPaths.setting),
                )
              )
            ),
    );
  }
}


//Constants
class HomePageViewConsts {
  static double todayCardIconSize = 36.0;
  static double todayCardSize = 100;
  static double infogramContainerSize = 130;
  static double recordedCardHeight = 130;
  static double infogramCardWidth = 300;
}