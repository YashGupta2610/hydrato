
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class AccountController extends GetxController{
  static AccountController  to = Get.find();
  final accDetial = GetStorage();
 Rx <UserDetails> user =  UserDetails('Your Name','Male/Female','Age','Height','Weight').obs;

  final formKey = GlobalKey<FormState>();

  void storeUserDetials(){
    accDetial.write("userDetails", user);
  }

  UserDetails  getUserDetails(){
    return accDetial.read("userDetails");
  }
}