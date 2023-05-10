
import 'dart:math';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class BodyMeasurementController extends GetxController{
  final storage = GetStorage();
     late var bmi;
     late double height;
     late double weight;

   void onInit(){
         super.onInit();

       storage.writeIfNull("userHeight","0");
       storage.writeIfNull("userWeight", "0");

   }

  String calculateBMI() {
    if(storage.read('userHeight') != null){
      height = double.parse(storage.read("userHeight").toString());
      weight = double.parse(storage.read("userWeight").toString());
    }
   else {
     height = 0;
     weight =0;     }
    try {
    bmi= (weight / pow(height * 0.3048 , 2)).toStringAsFixed(2);
  }
  catch(e){
       bmi = 0;
  }
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