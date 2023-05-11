
import 'package:hydrato/controllers/water_level_controller.dart';
import 'package:hydrato/ui_view/body_measurement.dart';
import 'package:hydrato/ui_view/glass_view.dart';
import 'package:hydrato/ui_view/mediterranean_diet_view.dart';
import 'package:hydrato/ui_view/title_view.dart';
import 'package:hydrato/fitness_app_theme.dart';
import 'package:hydrato/my_diary/meals_list_view.dart';
import 'package:hydrato/my_diary/water_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../ui_view/appBar_component.dart';
import '../ui_view/formFeild_component.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      TitleView(
        titleTxt: 'Your  diet',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!, () {}
      ),
    );
    listViews.add(
      MediterranesnDietView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Meals today',
        subTxt: 'Customize',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!, () {}
      ),
    );

    listViews.add(
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Body measurement',
        subTxt: 'Update',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!, () {
          Get.dialog(
            AlertDialog(
              content: Text("Update Height and Weight on Account Screen", style: FitnessAppTheme.body1,),
            )
          );
      }
      ),
    );

    listViews.add(
      BodyMeasurementView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Water',
        subTxt: 'Reset Goal & Timer',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!, () {

          Get.dialog(
            AlertDialog(
              content: GetBuilder<WaterController>(
                builder: (waterCtrl) {
                  return Column(
                    children: [
                      FormFieldCustom().MyAccountUpdateForm("Set Goal", (value) =>
                      {
                        waterCtrl.waterIntakeDetails.value.goal = value!,
                        print(waterCtrl.waterIntakeDetails.value.goal),
                      }, widget.animationController,
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: widget.animationController!,
                                  curve: Interval(
                                      (1 / count) * 4, 1.0,
                                      curve: Curves.fastOutSlowIn)))),

                      FormFieldCustom().MyAccountUpdateForm("Set Intake Volume ", (value) =>
                      {
                        waterCtrl.waterIntakeDetails.value.waterIntakeLevel = value!,
                        print(waterCtrl.waterIntakeDetails.value.waterIntakeLevel),
                      }, widget.animationController,
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: widget.animationController!,
                                  curve: Interval(
                                      (1 / count) * 4, 1.0,
                                      curve: Curves.fastOutSlowIn)))),

                      FormFieldCustom().MyAccountUpdateForm(
                          "Set Bottle Volume ", (value) =>
                      {
                        waterCtrl.waterIntakeDetails.value.bottleSize = value!,
                        print(waterCtrl.waterIntakeDetails.value.bottleSize),
                      }, widget.animationController,
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: widget.animationController!,
                                  curve: Interval(
                                      (1 / count) * 4, 1.0,
                                      curve: Curves.fastOutSlowIn)))),

                      SizedBox(
                        height: 60,
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: () {
                            waterCtrl.formKey.currentState?.save();
                            waterCtrl.storeDetials();
                            // listViews.add(Obx(()=> Text("${accountCtrl.user.name}")));
                            waterCtrl.update();
                            Get.back();
                          }, child: Text(
                            "Submit", style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.18,
                            color: FitnessAppTheme.nearlyWhite,
                          ),
                          ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    FitnessAppTheme.nearlyDarkBlue)
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              )
            )
          );
      }
      ),
    );

    listViews.add(
      WaterView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 7, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController!,
      ),
    );
    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController!),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            AppBarComponent().getAppBarUI(
                'My Diary', widget.animationController, topBarAnimation,
                topBarOpacity),

            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height +
                        MediaQuery.of(context).padding.top +
                        24,
                    bottom: 62 + MediaQuery.of(context).padding.bottom,
                  ),
                  itemCount: listViews.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    widget.animationController?.forward();
                    return listViews[index];
                  },
                ),
              ),
        //       WaterView(
        //       mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
        // CurvedAnimation(
        // parent: widget.animationController!,
        // curve: Interval((1 / 8) * 7, 1.0,
        // curve: Curves.fastOutSlowIn))),
        // mainScreenAnimationController: widget.animationController!,
        // ),
        // ),
            ],
          );
        }
      },
    );
  }

}
