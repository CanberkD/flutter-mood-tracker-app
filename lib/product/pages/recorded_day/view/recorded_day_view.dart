import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
import 'package:flutter_mood_tracker/product/components/text/subtitle_text.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
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

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(13),
          child: CircularIconButton(
            child: Icon(Icons.chevron_left, color: ProjectColors.primaryBlack.value()),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(ProjectDateTime().convertStringDateForRecordedDayAll(recordedMoodModel.date.day, recordedMoodModel.date.month, recordedMoodModel.date.year), style: TextStyle(color: ProjectColors.primaryBlack.value())),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: PaddingSizes.mainColumHorizontalPadding.value()),
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
                                  children: [
                                    SubTitle(text: recordedMoodModel.moodList[index].hour, padding: EdgeInsets.zero),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        height: ImageSizes.recordedDayListTileMoodImageSize.value(),
                                        width: ImageSizes.recordedDayListTileMoodImageSize.value(),
                                        child: Image.asset(recordedMoodModel.moodList[index].moodImgPath)
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
                                      Expanded(child: Text('Activity: ', style: Theme.of(context).textTheme.headline6,)),
                                      Expanded(child: Text(recordedMoodModel.moodList[index].activity, style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w300),)),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(child: Text('Peoples With: ', style: Theme.of(context).textTheme.headline6)),
                                      Expanded(child: Text(recordedMoodModel.moodList[index].peoplesWith.toString().replaceAll("]","").replaceAll("[",""), style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w300,)))
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