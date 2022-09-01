import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/consts/text.dart';

import '../../components/button/icon_button.dart';
import '../../consts/color.dart';
import '../../consts/size.dart';
import '../viewmodel/homepage_viewmodel.dart';
import 'homepage_view.dart';

class TodayBar extends StatelessWidget {
  const TodayBar({
    Key? key,
    required HomePageViewModel model,
  }) : _model = model, super(key: key);

  final HomePageViewModel _model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SubTitle(text: ProjectText.homepageSubtitleToday),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: HomePageViewConsts.todayCardSize,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder:(context, index) {
            return Padding(
              padding: index == 0 ? 
              EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value(), right: PaddingSizes.small.value()) :
              EdgeInsets.only(right: PaddingSizes.small.value()) ,
              child: index != 9 ? TodayMoodsListCard(model: _model) : addMoodButton(),
            );
          },
      ),
      ),
      ],
    );
  }

  SizedBox addMoodButton() {
    return SizedBox(
                width: HomePageViewConsts.todayCardSize,
                height: HomePageViewConsts.todayCardSize,
                child: ElevatedButton(onPressed: () {
                
                }, child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  SizedBox(width: HomePageViewConsts.todayCardIconSize, height: HomePageViewConsts.todayCardIconSize, child: Image.asset(_model.pngPaths.getLightPlus())),
                  const Text('Add mood'),
                ],
                )
            ),
              );
  }
}

class SubTitle extends StatelessWidget {
  final String text;

  const SubTitle({
    Key? key, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value()),
      child: Align(
        alignment: Alignment.centerLeft, 
        child: Text(text, 
        style: Theme.of(context).textTheme.subtitle1?.copyWith(color: ProjectColors.primaryBlack.value(), fontSize: FontSizes.subHeader.value()),)),
    );
  }
}

class TodayMoodsListCard extends StatelessWidget {
  const TodayMoodsListCard({
    Key? key,
    required HomePageViewModel model,
  }) : _model = model, super(key: key);

  final HomePageViewModel _model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: HomePageViewConsts.todayCardSize,
      height: HomePageViewConsts.todayCardSize,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          SizedBox(
            width: HomePageViewConsts.todayCardIconSize, 
            height: HomePageViewConsts.todayCardIconSize, 
            child: Image.asset(_model.pngPaths.happy
            )
          ),
          const Text('12:22')
        ],),
      ),
    );
  }
}


class HelloBar extends StatelessWidget {
  const HelloBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ProjectText.homepageTitleHello, 
        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: FontSizes.header.value(), fontWeight: FontWeights.header.value())),
        Text('${ProjectText.homepageDateToday} August 17' , style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}


class RecordedList extends StatelessWidget {
  const RecordedList({
    Key? key,
    required HomePageViewModel model,
  }) : _model = model, super(key: key);

  final HomePageViewModel _model;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: PaddingSizes.mainColumHorizontalPadding.value()),
        child: SizedBox(
          height: HomePageViewConsts.recordedCardHeight,
          child: Card(
            child: InkWell(
              onTap: () {
                
              },
              child: Column(
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('1$index August', style: Theme.of(context).textTheme.subtitle1,),
                  const Icon(Icons.chevron_right_outlined)
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    height: HomePageViewConsts.todayCardIconSize,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: PaddingSizes.small.value()),
                          child: SizedBox(
                            width: HomePageViewConsts.todayCardIconSize,
                            height: HomePageViewConsts.todayCardIconSize,
                            child: Image.asset(_model.pngPaths.happy)),
                        );
                    },),
                  ),
                )
              ]),
            ),
          ),
        ),
      );
    },);
  }
}

class RecordedTopBar extends StatelessWidget {
  const RecordedTopBar({
    Key? key,
    required HomePageViewModel model,
  }) : _model = model, super(key: key);

  final HomePageViewModel _model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: PaddingSizes.mainColumnVerticalPadding.value()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SubTitle(text: ProjectText.homepageSubtitleRecorded),
          Padding(
            padding: EdgeInsets.only(right: PaddingSizes.mainColumHorizontalPadding.value()),
            child: CircularIconButton(child: Padding(
              padding: EdgeInsets.all(PaddingSizes.iconButtonChildPadding.value()),
              child: Image.asset(_model.pngPaths.filter),
            ), onPressed: () {
              
            },),
          )
        ],
      ),
    );
  }
}
