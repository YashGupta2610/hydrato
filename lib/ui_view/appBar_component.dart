import 'package:flutter/material.dart';
import 'package:hydrato/controllers/appBar_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../fitness_app_theme.dart';

class AppBarComponent  {
  Widget getAppBarUI(String title,AnimationController? animationController,
      Animation<double>? topBarAnimation, double topBarOpacity,
      ) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation:animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .padding
                            .top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              // child: InkWell(
                              //   highlightColor: Colors.transparent,
                              //   borderRadius: const BorderRadius.all(
                              //       Radius.circular(32.0)),
                              //   onTap: () {},
                              //   child: Center(
                              //     child: Icon(
                              //       Icons.keyboard_arrow_left,
                              //       color: FitnessAppTheme.grey,
                              //     ),
                              //   ),
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: GetBuilder<AppBarController>(
                                builder: (ctrl) {
                                  return InkWell(
                                    highlightColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(32.0)),
                                    onTap: (){
                                      Get.dialog(
                                          AlertDialog(
                                            actions: [
                                              IconButton(onPressed: () {
                                                Get.back();
                                              }, icon: Icon(Icons.cancel,
                                                color: FitnessAppTheme
                                                    .nearlyBlue,))
                                            ],
                                            content: Container(
                                              height: 300,
                                              width: 300,

                                              child: CalendarDatePicker(

                                                  currentDate: ctrl.curDate,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2002),
                                                  lastDate: DateTime(2090),
                                                  onDateChanged: (
                                                      DateTime value) {
                                                    ctrl.newDate = value;
                                                    ctrl.update();
                                                  }),
                                            ),
                                          )
                                      );
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.calendar_today,
                                            color: FitnessAppTheme.grey,
                                            size: 18,
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat('MMM d').format(
                                              DateTime.now()).toString()}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                            letterSpacing: -0.2,
                                            color: FitnessAppTheme.darkerText,
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          color: FitnessAppTheme.grey,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              // child: InkWell(
                              //   highlightColor: Colors.transparent,
                              //   borderRadius: const BorderRadius.all(
                              //       Radius.circular(32.0)),
                              //   onTap: () {},
                              //   child: Center(
                              //     child: Icon(
                              //       Icons.keyboard_arrow_right,
                              //       color: FitnessAppTheme.grey,
                              //     ),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}