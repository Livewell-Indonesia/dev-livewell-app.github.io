import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/splash/presentation/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(Constant.imgLogo),
        ),
      ),
    );
  }
}
