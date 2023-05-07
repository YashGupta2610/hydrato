import 'package:flutter/material.dart';

import 'package:hydrato/controllers/account_controller.dart';
import 'package:hydrato/ui_view/appBar_component.dart';

import 'package:hydrato/ui_view/title_view.dart';
import 'package:hydrato/ui_view/running_view.dart';


import '../fitness_app_theme.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  AccountController accountCtrl = AccountController.to;
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
    const int count = 4;

    listViews.add(
      TitleView(
        titleTxt: 'Your Account',
        subTxt: 'Update',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!, () {
          Get.dialog(
            AlertDialog(
              actions: [IconButton(onPressed: (){
                Get.back();
                accountCtrl.update();
              }, icon: Icon(Icons.cancel,color: FitnessAppTheme.nearlyDarkBlue,))],
              content: SizedBox(
                height: 400,
                width:  600,
                child: Form(
                  key: accountCtrl.formKey,
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyAccountUpdateForm('Name', (value) =>
                      {
                        accountCtrl.user.value.name = value!,
                        print(accountCtrl.user.value.name),
                      }, widget.animationController,
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: widget.animationController!,
                                  curve: Interval(
                                      (1 / count) * 4, 1.0,
                                      curve: Curves.fastOutSlowIn)))
                      ),
                      MyAccountUpdateForm('Gender', (value) =>
                      {
                        accountCtrl.user.value.gender = value!,
                        print(accountCtrl.user.value.gender),
                      }, widget.animationController,
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: widget.animationController!,
                                  curve: Interval(
                                      (1 / count) * 4, 1.0,
                                      curve: Curves.fastOutSlowIn)))
                      ),
                      MyAccountUpdateForm('Age', (value) =>
                      {
                        accountCtrl.user.value.age = value!,
                        print(accountCtrl.user.value.age),
                      }, widget.animationController,
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: widget.animationController!,
                                  curve: Interval(
                                      (1 / count) * 4, 1.0,
                                      curve: Curves.fastOutSlowIn)))
                      ),
                      MyAccountUpdateForm('Height', (value) =>
                      {
                        accountCtrl.user.value.height = value!,
                        print(accountCtrl.user.value.height),
                      }, widget.animationController,
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: widget.animationController!,
                                  curve: Interval(
                                      (1 / count) * 4, 1.0,
                                      curve: Curves.fastOutSlowIn)))
                      ),
                      MyAccountUpdateForm('Weight', (value) =>
                      {
                        accountCtrl.user.value.weight = value!,
                        print(accountCtrl.user.value.weight),
                      }, widget.animationController,
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: widget.animationController!,
                                  curve: Interval(
                                      (1 / count) * 4, 1.0,
                                      curve: Curves.fastOutSlowIn)))
                      ),
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: () {
                            accountCtrl.formKey.currentState?.save();
                            // accountCtrl.storeUserDetials();
                            print(accountCtrl.user.value.name);
                            // listViews.add(Obx(()=> Text("${accountCtrl.user.name}")));
                            accountCtrl.update();
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
                  ),
                ),
              )
              ,
            )
          );
      }

      ),
    );

    // listViews.add(
    //   WorkoutView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //         Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );


    listViews.add(

      AnimatedBuilder(
        animation: widget.animationController!,
        builder: ( context, Widget? child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController!,
                    curve:
                    Interval(
                        (1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CircleAvatar(
                radius: 63,
                backgroundColor: FitnessAppTheme.nearlyDarkBlue,
                child: CircleAvatar(
                  radius: 60,

                  backgroundImage: AssetImage(
                   "fitness_app/avatarF.png",
                  ),
                ),
              ),
            ),
          );
        }
      ),
      // TitleView(
      //   titleTxt: 'Area of focus',
      //   subTxt: 'more',
      //   animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      //       parent: widget.animationController!,
      //       curve:
      //       Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
      //   animationController: widget.animationController!,
      // ),
    );
    listViews.add(
      Column(
        children: [
          Obx (()=> Text("${accountCtrl.user.value.name}")),
          Obx (()=> Text("${accountCtrl.user.value.gender}")),
          Obx (()=> Text("${accountCtrl.user.value.age}")),
          Obx (()=> Text("${accountCtrl.user.value.height}")),
          Obx (()=> Text("${accountCtrl.user.value.weight}")),
        ],
      )
    );

    listViews.add(
      RunningView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }
Widget MyAccountUpdateForm(String title, Function(String?) onSaved, animationController, Animation<double> aniamtionOpc){
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: aniamtionOpc,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
            child: TextFormField(
              decoration: InputDecoration(
              // hoverColor: FitnessAppTheme.nearlyBlue,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width:8,
                      color: FitnessAppTheme.nearlyDarkBlue,
                  style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                counterStyle: FitnessAppTheme.subtitle,
                hintText: title,
                // contentPadding: EdgeInsets.all(15.0),
                // border: InputBorder.none,
                filled: true,
                fillColor: FitnessAppTheme.nearlyWhite,
              ),
              onSaved: onSaved,

            ),
          ),
        );
      }
    );
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
            AppBarComponent().getAppBarUI('About You',widget.animationController,topBarAnimation,topBarOpacity),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .padding
                  .bottom,
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
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery
                      .of(context)
                      .padding
                      .top +
                  24,
              bottom: 62 + MediaQuery
                  .of(context)
                  .padding
                  .bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

}
