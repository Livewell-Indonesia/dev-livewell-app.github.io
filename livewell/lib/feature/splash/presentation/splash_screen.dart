import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/splash/presentation/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              AspectRatio(
                aspectRatio: 5,
                child: SvgPicture.asset(
                  "assets/images/FA_Livewell_Logo.svg",
                  fit: BoxFit.cover,
                  color: const Color(0xFF34EAB2),
                ),
              ),
              Text(controller.localization.landingPage?.betterHealthThroughBetterLiving ?? "Better Health Through Better Living".tr,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433).withOpacity(0.5))),
              const Spacer(),
              SvgPicture.asset("assets/icons/kemenkes-icon.svg"),
              36.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
