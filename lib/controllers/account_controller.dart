import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class AccountController extends GetxController {
  static AccountController to = Get.find();
  final  accDetial = GetStorage();
  Rx<UserDetails> user = UserDetails("", '', '', '', '').obs;

  final formKey = GlobalKey<FormState>();

  Future<void> onInit() async {
    super.onInit();

      user.value.name =accDetial.read('userName')?? '';
      user.value.height =accDetial.read('userHeight')?? '0';
      user.value.weight = accDetial.read('userWeight')?? '0';
      user.value.age =accDetial.read('userAge')?? '';
      user.value.gender = accDetial.read('userGender') ?? '';

  }

  void storeUserDetials() async {
  await  accDetial.write("userName", user.value.name);
  await  accDetial.write("userGender", user.value.gender);
  await  accDetial.write("userAge", user.value.age);
  await  accDetial.write("userWeight", user.value.weight);
  await  accDetial.write("userHeight", user.value.height);
  }

  UserDetails getUserDetails() {
    return accDetial.read("userDetails");

  }
}