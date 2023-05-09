
import 'dart:math';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class BodyMeasurementController extends GetxController{
  final storage = GetStorage();
     late var bmi;

   void onInit(
       ){
     if(storage.read('userHeight') == null || storage.read("userHeight") == null){
       storage.write("userHeight", '');
       storage.write("userWeight", '');
     }
   }

  String calculateBMI() {
    double  height =double.parse(storage.read("userHeight"));
    double  weight = double.parse(storage.read("userWeight"));
    print(weight);
    print(height);
    bmi= (weight / pow(height * 0.3048 , 2)).toStringAsFixed(2);
    return bmi.toString();
  }

  String getResult(bmi) {
     bmi = double.parse(bmi);
    if (bmi >= 25) {
      return 'Overweight';
    } else if (bmi > 18.5) {
      return "Normal";
    }
    else {
      return 'Underweight';
    }
  }
}