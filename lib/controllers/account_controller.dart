import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class AccountController extends GetxController {
  static AccountController to = Get.find();
  final Rx accDetial = GetStorage().obs;
  Rx<UserDetails> user = UserDetails("", '', '', '', '').obs;

  final formKey = GlobalKey<FormState>();

  Future<void> onInit() async {
    if (accDetial.value.read('userName') != '') {
      user.value.name = accDetial.value.read('userName');
      user.value.height = accDetial.value.read('userHeight');
      user.value.weight = accDetial.value.read('userWeight');
      user.value.age = accDetial.value.read('userAge');
      user.value.gender = accDetial.value.read('userGender');
    }
    else {
      user.value.name = '';
      user.value.height = '';
      user.value.weight = '';
      user.value.age = '';
      user.value.gender = '';
    }
  }

  void storeUserDetials() {
    accDetial.value.write("userName", user.value.name);
    accDetial.value.write("userGender", user.value.gender);
    accDetial.value.write("userAge", user.value.age);
    accDetial.value.write("userWeight", user.value.weight);
    accDetial.value.write("userHeight", user.value.height);
  }

  UserDetails getUserDetails() {
    return accDetial.value.read("userDetails");

  }
}