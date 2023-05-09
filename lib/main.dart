import 'dart:io';

import 'package:get/get.dart';

import 'package:hydrato/controllers/appBar_controller.dart';

import 'controllers/account_controller.dart';
import 'controllers/myDairy_Controller.dart';
import 'fitness_app_home_screen.dart';
import 'fitness_app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppBarController());
  Get.put(BodyMeasurementController());
  // Get.lazyPut<BodyMeasurementController>(()=>BodyMeasurementController());

  Get.put(AccountController());


  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Theme settings
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      title: 'Hydrato',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: FitnessAppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: FitnessAppHomeScreen(),
    );
  }
}


// Class that makes hex code of colors in Colors
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
