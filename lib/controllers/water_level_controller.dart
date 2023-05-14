import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hydrato/models/WaterIntake.dart';
import 'package:intl/intl.dart';

class WaterController extends GetxController{
 static  WaterController to = Get.find();


 RxInt waterConsumed = 0.obs;

 var store=GetStorage();
 late Rx<WaterIntakeDetails> waterIntakeDetails =  WaterIntakeDetails('3.5', "150", '1', DateFormat("HH:mm a").format(DateTime.now()), '30', '0').obs;
 final formKey = GlobalKey<FormState>();
 RxDouble waterPercentage = 0.0.obs;
 late int waterBottleSize;


 Future<void> onInit() async {
  await store.writeIfNull("WaterIntakeGoal", waterIntakeDetails.value.goal);
  await store.writeIfNull("WaterIntake", waterIntakeDetails.value.waterIntakeLevel);
  await store.writeIfNull("WaterBottleSize", waterIntakeDetails.value.bottleSize);
  await store.writeIfNull("WaterLastIntake", waterIntakeDetails.value.lastDrunk);
 waterBottleSize = int.parse(store.read("WaterBottleSize")) ?? 1;
 }


 Future<void> storeDetials() async {
 await  store.write("WaterIntakeGoal", waterIntakeDetails.value.goal);
 await  store.write("WaterIntake", waterIntakeDetails.value.waterIntakeLevel);
 await  store.write("WaterBottleSize", waterIntakeDetails.value.bottleSize);
 // await  store.write("WaterLastIntake", waterIntakeDetails.value.lastDrunk);
 update();
 }

 void onWaterAdd(){
  if(waterConsumed.value < (double.parse('${store.read("WaterIntakeGoal")}')*1000)){
   waterConsumed.value = waterConsumed.value + int.parse('${store.read('WaterIntake')}');
   waterPercentage.value = (waterConsumed / ((double.parse('${store.read("WaterIntakeGoal")}') * 1000))*100).toDouble();
   store.write('WaterLastIntake', DateFormat("HH:mm a").format(DateTime.now()));}
  if(waterConsumed.value >= waterBottleSize){
   waterBottleSize = waterBottleSize + waterBottleSize;
  }
  update();
  // return waterConsumed.value.toString();
 }

 void  onWaterRemove() {
  if(waterConsumed.value >0 )
  waterConsumed.value = waterConsumed.value -  int.parse('${store.read('WaterIntake')}');
  waterPercentage.value = (waterConsumed / ((double.parse('${store.read("WaterIntakeGoal")}') * 1000)))*100;

  update();
  // return waterConsumed.value.toString();
 }

 String waterLevelInBottleMessage(){
 int  waterLeft = (waterBottleSize*1000) - waterConsumed.value;
 int waterIntake = int.parse('${store.read('WaterIntake')}');
 if(waterLeft <= waterIntake*2){
  return 'Your bottle is almost empty, max 2 intakes left';
 }
 if(waterLeft < 0 ){
  return 'Your bottle is empty, please refill!';

 }
 if(waterLeft > waterIntake*3){
  return 'Keep Yourself Hydrated! Drink Water Now';
 }
 return 'Good Job Keep Going';
 }

}