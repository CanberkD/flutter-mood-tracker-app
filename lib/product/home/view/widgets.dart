import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/consts/text.dart';
import 'package:flutter_mood_tracker/product/model/date_time.dart';

import '../../components/button/icon_button.dart';
import '../../consts/color.dart';
import '../../consts/size.dart';
import '../viewmodel/homepage_viewmodel.dart';
import 'homepage_view.dart';


class HelloBar extends StatelessWidget {

  const HelloBar({
    Key? key, required this.model,
  }) : super(key: key);

  final HomePageViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ProjectText.homepageTitleHello, 
        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: FontSizes.header.value(), fontWeight: FontWeights.header.value())),
        Text(model.helloBarDateStr , style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}


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
            itemCount: _model.todayList.length + 1, //+1 for add mood button end of list.
            itemBuilder:(context, index) {
            return Padding(
              padding: index == 0 ? 
              EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value(), right: PaddingSizes.small.value()) :
              EdgeInsets.only(right: PaddingSizes.small.value()) ,
              child: (index == _model.todayList.length) ?
              addMoodButton() : 
              TodayMoodsListCard(model: _model, hour: _model.todayList[index].hour, moodImgPaht: _model.todayList[index].moodImgPath,),
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
class TodayMoodsListCard extends StatelessWidget {
  const TodayMoodsListCard({
    Key? key,
    required HomePageViewModel model,
    required String moodImgPaht,
    required String hour,
  }) : 
  _model = model, 
  _hour = hour,
  _moodImgPath = moodImgPaht,
  super(key: key);

  final HomePageViewModel _model;
  final String _moodImgPath;
  final String _hour;

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
            child: Image.asset(_moodImgPath)
          ),
          Text(_hour)
        ],),
      ),
    );
  }
}

class Infogram extends StatelessWidget {
  const Infogram({
    Key? key,
    required HomePageViewModel model,
  }) : _model = model, super(key: key);

  final HomePageViewModel _model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: HomePageViewConsts.infogramContainerSize,
      child: ListView.builder(
        itemCount: _model.infogramList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index1) {
          return Padding(
            padding: index1 == 0 ? EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value()) : EdgeInsets.only(left: PaddingSizes.small.value()),
            child: SizedBox(
              width: HomePageViewConsts.infogramCardWidth,
              child: Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          _model.infogramList[index1].getTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  fontWeight: FontWeights.header.value()),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _model.infogramList[index1].getItems.length,
                        itemBuilder: (context, index) {
                          return Center(child: Text(_model.infogramList[index1].getItems[index]));
                        },)
                    ]),
              ),
            ),
          );
        },
      ),
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
      itemCount: _model.recordedList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index1) {
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
                  Text(ProjectDateTime().convertStringDateForRecordedDay(_model.recordedList[index1].date.day, _model.recordedList[index1].date.month), style: Theme.of(context).textTheme.subtitle1,),
                  const Icon(Icons.chevron_right_outlined)
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    height: HomePageViewConsts.todayCardIconSize,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _model.recordedList[index1].moodList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: PaddingSizes.small.value()),
                          child: SizedBox(
                            width: HomePageViewConsts.todayCardIconSize,
                            height: HomePageViewConsts.todayCardIconSize,
                            child: Image.asset(_model.recordedList[index1].moodList[index].moodImgPath)),
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
