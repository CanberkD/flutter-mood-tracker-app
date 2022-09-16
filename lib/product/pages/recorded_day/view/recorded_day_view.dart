import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/go_back_button.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/image_paths.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/model/date_time.dart';
import 'package:flutter_mood_tracker/product/model/recorded_mood_model.dart';

class RecordedDayView extends StatelessWidget {

  const RecordedDayView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final recordedMoodModel = ModalRoute.of(context)!.settings.arguments as RecordedMoodModel;
    PngPaths pngPathsDark = PngPaths(themeInfo: ThemeInfo.dark);
    PngPaths pngPaths = PngPaths(themeInfo: Theme.of(context).brightness == Brightness.light ? ThemeInfo.dark: ThemeInfo.light);
    return Scaffold(
      appBar: AppBar(
        leading: const GoBackIconButton(isThemeChange: false,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(ProjectDateTime().convertStringDateForRecordedDayAll(recordedMoodModel.date.day, recordedMoodModel.date.month, recordedMoodModel.date.year), style: Theme.of(context).textTheme.subtitle1),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: PaddingSizes.mainColumHorizontalPadding.value()),
              child: ListView.builder(
                itemCount: recordedMoodModel.moodList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Divider(color: ProjectColors.primaryBlack.value(),),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: PaddingSizes.mainColumHorizontalPadding.value()),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SubTitle(text: recordedMoodModel.moodList[index].hour, padding: EdgeInsets.zero),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        height: ImageSizes.recordedDayListTileMoodImageSize.value(),
                                        width: ImageSizes.recordedDayListTileMoodImageSize.value(),
                                        child: Image.asset(
                                          recordedMoodModel.moodList[index].moodImgPath == pngPathsDark.happy ? 
                                            pngPaths.happy :
                                          recordedMoodModel.moodList[index].moodImgPath == pngPathsDark.notr ? 
                                            pngPaths.notr : pngPaths.sad
                                          )
                                      ),
                                    ),
                                  ]
                                ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text('activitydoubledot'.tr(), style: Theme.of(context).textTheme.headline6,)),
                                      Expanded(child: Text(recordedMoodModel.moodList[index].activity, style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w300, fontSize: 16),)),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(child: Text('peopleswith'.tr(), style: Theme.of(context).textTheme.headline6)),
                                      Expanded(child: Text(recordedMoodModel.moodList[index].peoplesWith.toString().replaceAll("]","").replaceAll("[",""), style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w300, fontSize: 16)))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      (index == recordedMoodModel.moodList.length - 1) ? Divider(color: ProjectColors.primaryBlack.value(),) : const SizedBox.shrink()
                    ],
                  );
                },
              ),
            ),
          )
        ],
      )
    );
  }
}