import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mood_tracker/core/components/basic/bottom_sheet_divider.dart';
import 'package:flutter_mood_tracker/product/components/text/header_text.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/consts/text.dart';
import 'package:flutter_mood_tracker/product/model/date_time.dart';
import 'package:flutter_mood_tracker/product/navigation/navigation_routres.dart';

import '../../../components/button/icon_button.dart';
import '../../../consts/size.dart';
import '../viewmodel/homepage_viewmodel.dart';
import 'homepage_view.dart';

class HelloBar extends StatelessWidget {
  const HelloBar({
    Key? key,
    required this.model,
  }) : super(key: key);

  final HomePageViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderTextWidget(text: ProjectText.homepageTitleHello),
        Text(model.helloBarDateStr,
            style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}

class TodayBar extends StatelessWidget {
  const TodayBar({
    Key? key,
    required HomePageViewModel model,
    required this.context,
  })  : _model = model,
        super(key: key);

  final HomePageViewModel _model;
  final BuildContext context;

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
            itemCount: _model.todayList.length +
                1, //+1 for add mood button end of list.
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0
                    ? EdgeInsets.only(
                        left: PaddingSizes.mainColumHorizontalPadding.value(),
                        right: PaddingSizes.small.value())
                    : EdgeInsets.only(right: PaddingSizes.small.value()),
                child: (index == _model.todayList.length)
                    ? addMoodButton()
                    : TodayMoodsListCard(
                        hour: _model.todayList[index].hour,
                        moodImgPaht: _model.todayList[index].moodImgPath,
                      ),
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
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.addMood.name);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: HomePageViewConsts.todayCardIconSize,
                  height: HomePageViewConsts.todayCardIconSize,
                  child: Image.asset(_model.pngPaths.getLightPlus())),
              const Text('Add mood'),
            ],
          )),
    );
  }
}

class TodayMoodsListCard extends StatelessWidget {
  const TodayMoodsListCard({
    Key? key,
    required String moodImgPaht,
    required String hour,
  })  : _hour = hour,
        _moodImgPath = moodImgPaht,
        super(key: key);

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
                child: Image.asset(_moodImgPath)),
            Text(_hour)
          ],
        ),
      ),
    );
  }
}

class Infogram extends StatelessWidget {
  const Infogram({
    Key? key,
    required HomePageViewModel model,
  })  : _model = model,
        super(key: key);

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
            padding: index1 == 0
                ? EdgeInsets.only(
                    left: PaddingSizes.mainColumHorizontalPadding.value())
                : EdgeInsets.only(right: PaddingSizes.small.value()),
            child: SizedBox(
              width: HomePageViewConsts.infogramCardWidth,
              child: Card(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ) +
                        const EdgeInsets.only(top: 5),
                    child: Text(
                      _model.infogramList[index1].getTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeights.header.value()),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _model.infogramList[index1].getItems.length,
                        itemBuilder: (context, index) {
                          return Center(
                              child: Text(
                                  _model.infogramList[index1].getItems[index]));
                        },
                      ),
                    ),
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

class RecordedList extends StatelessWidget {
  const RecordedList({
    Key? key,
    required HomePageViewModel model,
  })  : _model = model,
        super(key: key);

  final HomePageViewModel _model;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _model.recordedList.length,
        shrinkWrap: true,
        reverse: true, //For today to earlier list.
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index1) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: PaddingSizes.mainColumHorizontalPadding.value()),
            child: SizedBox(
              height: HomePageViewConsts.recordedCardHeight,
              child: Card(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.recordedDay.name, arguments: _model.recordedList[index1]);
                  },
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ProjectDateTime().convertStringDateForRecordedDay(
                              _model.recordedList[index1].date.day,
                              _model.recordedList[index1].date.month),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const Icon(Icons.chevron_right_outlined)
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        height: HomePageViewConsts.todayCardIconSize,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: PaddingSizes
                                  .mainColumHorizontalPadding
                                  .value()),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                _model.recordedList[index1].moodList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: PaddingSizes.medium.value()),
                                child: SizedBox(
                                    width: HomePageViewConsts.todayCardIconSize,
                                    height:
                                        HomePageViewConsts.todayCardIconSize,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(_model.recordedList[index1]
                                            .moodList[index].moodImgPath),
                                        Text(_model.recordedList[index1]
                                            .moodList[index].hour),
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class RecordedTopBar extends StatelessWidget {
  const RecordedTopBar({
    Key? key,
    required HomePageViewModel model,
  })  : _model = model,
        super(key: key);

  final HomePageViewModel _model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: PaddingSizes.mainColumnVerticalPadding.value()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SubTitle(text: ProjectText.homepageSubtitleRecorded),
          Padding(
            padding: EdgeInsets.only(
                right: PaddingSizes.mainColumHorizontalPadding.value()),
            child: Row(
              children: [
                CircularIconButton(
                  child: Padding(
                    padding:
                        EdgeInsets.all(PaddingSizes.iconButtonChildPadding.value()),
                    child: Image.asset(_model.pngPaths.filter),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                  RoundSizes.showModelMainSize.value()))),
                      context: context,
                      builder: (context) => RecordedListFilter(model: _model),
                    );
                  },
                ),
                SizedBox(width: PaddingSizes.small.value(),),
                CircularIconButton(
                    onPressed: () => _model.clearFilter(context),
                    child: Padding(
                    padding: EdgeInsets.all(
                        PaddingSizes.iconButtonChildPadding.value()),
                    child: Image.asset(
                        PngPaths(themeInfo: ThemeInfo.dark)
                            .filterClear),
                  ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RecordedListFilter extends StatelessWidget {
  const RecordedListFilter({
    Key? key,
    required HomePageViewModel model,
  })  : _model = model,
        super(key: key);

  final HomePageViewModel _model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const BottomSheetTopLine(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                        top: PaddingSizes.mainColumnVerticalPadding.value()) +
                    EdgeInsets.symmetric(
                        horizontal:
                            PaddingSizes.mainColumHorizontalPadding.value()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SubTitle(
                          text: 'Day',
                          padding: EdgeInsets.zero,
                        ),
                        Observer(builder: (_) {
                          return DropdownButton2<int>(
                            dropdownMaxHeight:
                                MediaQuery.of(context).size.height * 0.2,
                            dropdownWidth: 70,
                            value: _model.dayIndex,
                            onChanged: (value) =>
                                _model.dayIndex = value ?? _model.dayIndex,
                            items: _model.dropdownDayList,
                          );
                        }),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SubTitle(
                          text: 'Month',
                          padding: EdgeInsets.zero,
                        ),
                        Observer(builder: (_) {
                          return DropdownButton2<int>(
                            dropdownMaxHeight:
                                MediaQuery.of(context).size.height * 0.2,
                            dropdownWidth: 70,
                            value: _model.monthIndex,
                            onChanged: (value) =>
                                _model.monthIndex = value ?? _model.monthIndex,
                            items: _model.dropdownMonthList,
                          );
                        }),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SubTitle(
                          text: 'Year',
                          padding: EdgeInsets.zero,
                        ),
                        Observer(builder: (_) {
                          return DropdownButton2<int>(
                            dropdownMaxHeight:
                                MediaQuery.of(context).size.height * 0.2,
                            dropdownWidth: 70,
                            value: _model.yearIndex,
                            onChanged: (value) =>
                                _model.yearIndex = value ?? _model.yearIndex,
                            items: _model.dropdownYearList,
                          );
                        }),
                      ],
                    ),
                ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: PaddingSizes.mainColumnVerticalPadding.value()),
              child: ElevatedButton(
                  onPressed: () => _model.filterRecordedList(context), 
                  child: const Text('Filter')),
            ),
            
          ],
        ));
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
      padding: EdgeInsets.symmetric(
              horizontal: PaddingSizes.mainColumHorizontalPadding.value()) +
          EdgeInsets.only(top: PaddingSizes.small.value()),
      child: Text(text),
    );
  }
}
