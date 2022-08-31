import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/components/button/icon_button.dart';
import 'package:flutter_mood_tracker/product/consts/size.dart';
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
              padding: EdgeInsets.only(right: PaddingSizes.mainColumnPadding.value(), top: PaddingSizes.mainColumnPadding.value()),
              child: settingButton(),
            ),
            Padding(
              padding: EdgeInsets.only(left: PaddingSizes.mainColumnPadding.value()),
              child: const HelloBar(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: PaddingSizes.mainColumnPadding.value()),
                    child: const Align(alignment: Alignment.centerLeft, child: Text('Today',),),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: HomePageViewConsts.todayCardSize,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder:(context, index) {
                      return Padding(
                        padding: index == 0 ? 
                        EdgeInsets.only(left: PaddingSizes.mainColumnPadding.value(), right: PaddingSizes.small.value()) :
                        EdgeInsets.only(right: PaddingSizes.small.value()) ,
                        child: TodayMoodsListCard(model: _model),
                      );
                    },
                ),
                  )
                ],
              ),
            )
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

class HomePageViewConsts {
  static double todayCardIconSize = 32.0;
  static double todayCardSize = 100;

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
        Text('HELLO!', 
        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: FontSizes.header.value(), fontWeight: FontWeights.header.value())),
        Text('Today: August 17' , style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}
