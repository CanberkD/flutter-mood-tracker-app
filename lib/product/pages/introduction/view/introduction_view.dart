import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/core/components/modified_packages/introduction/src/introduction_slider.dart';
import 'package:flutter_mood_tracker/core/components/modified_packages/introduction/utils/buttons.dart';
import 'package:flutter_mood_tracker/core/components/modified_packages/introduction/utils/dot_indicator.dart';
import 'package:flutter_mood_tracker/core/components/modified_packages/introduction/utils/introduction_slider_item.dart';
import 'package:flutter_mood_tracker/product/consts/color.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
import 'package:flutter_mood_tracker/product/pages/home/view/homepage_view.dart';
import 'package:flutter_mood_tracker/product/storage/shared_pref.dart';
import 'package:lottie/lottie.dart';

class IntroductionView extends StatelessWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IntroductionSlider(
        dotIndicator: DotIndicator(selectedColor: ProjectColors.primaryBlue.value()),
        items: [
          IntroductionItem(context, IntroductionImgPath.notification.getPath(), 'remindernotificationintroduction'.tr(), 'remindernotificationsubtitle'.tr()),
          IntroductionItem(context, IntroductionImgPath.input.getPath(), 'inputmoodintroduction'.tr(), 'inputmoodsubtitle'.tr()),
          IntroductionItem(context, IntroductionImgPath.saved.getPath(), 'savemoodintroduction'.tr(), 'savemoodsubtitte'.tr()),
        ],
        doneClicked: () {
          SharedPref sharedPref = SharedPref();
          sharedPref.setString(SharedPrefKeys.is_first_time, '1');
        },
        done: const Done(
        child: Icon(Icons.done),
        home: HomePageView(),
        ),
        next: const Next(child: Icon(Icons.arrow_forward)),
        back: const Back(child: Icon(Icons.arrow_back)),
      ),
    );
  }

  IntroductionSliderItem IntroductionItem(BuildContext context, String path, String title, String subtitle) {
    return IntroductionSliderItem(
        logo: SizedBox(
          child: Lottie.asset(fit: BoxFit.fill, frameRate: FrameRate.max, path)),
        title: Center(child: Text(title, style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: FontSizes.subHeader.value(), fontWeight: FontWeight.bold, color: ProjectColors.primaryBlack.value()))),
        subtitle: Padding(
          padding: EdgeInsets.symmetric(horizontal: PaddingSizes.mainColumHorizontalPadding.value()),
          child: Text(subtitle,textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1,),
        ),
        backgroundColor: ProjectColors.primaryWhite.value(),
      );
  }
}

enum IntroductionImgPath{
  notification, input, saved
}
extension IntroductionImgPathExtension on IntroductionImgPath {
  String getPath (){
    switch(this){
      case IntroductionImgPath.notification:
        return 'assets/lottie/notification_in.json';
      case IntroductionImgPath.input:
        return 'assets/lottie/input.json';
      case IntroductionImgPath.saved:
        return 'assets/lottie/saved_mood.json';
    }
  }
}