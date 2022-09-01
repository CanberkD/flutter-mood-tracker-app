import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
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
                child: const HelloBar(),
              ),
              Padding(
                padding: EdgeInsets.only(top: PaddingSizes.mainColumnVerticalPadding.value(), bottom: PaddingSizes.mainColumnVerticalPadding.value()),
                child: TodayBar(model: _model),
              ),
              const SubTitle(text: ProjectText.homepageSubtitleInfogram),
              const Infogram(),
              RecordedTopBar(model: _model),
              RecordedList(model: _model)
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

class Infogram extends StatelessWidget {
  const Infogram({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: HomePageViewConsts.infogramContainerSize,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: index == 0 ? EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value()) : EdgeInsets.only(left: PaddingSizes.small.value()),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(PaddingSizes.medium.value()),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Peoples likes you',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(
                                fontWeight: FontWeights.header.value()),
                      ),
                      Column(
                        children: const [
                          Text('Arthur'),
                          Text('Josh'),
                          Text('Dutch'),
                        ],
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

//Constants
class HomePageViewConsts {
  static double todayCardIconSize = 32.0;
  static double todayCardSize = 100;
  static double infogramContainerSize = 124;
  static double recordedCardHeight = 100;
}