import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:livewell/core/base/base_controller.dart';

class LoginController extends BaseController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController forgotPasswordEmail = TextEditingController();
  var showOtpInput = false.obs;

  // create function when button sendveritication tapped
  void sendVerification() {
    showOtpInput.value = true;
  }

  void verifyOTP() {}
}
