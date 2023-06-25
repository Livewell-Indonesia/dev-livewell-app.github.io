import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

import '../../../../widgets/buttons/livewell_button.dart';

class SuccessRequestFoodScreen extends StatelessWidget {
  const SuccessRequestFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: Get.find<HomeController>().localization.foodRequestCompleted!,
        body: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Get.find<HomeController>().localization.thankYou!,
                style: TextStyle(
                    color: const Color(0xFF171433),
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600),
              ),
              30.verticalSpace,
              Text(
                Get.find<HomeController>()
                    .localization
                    .ourTeamWorkingOnYourRequest!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFF171433).withOpacity(0.8),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500),
              ),
              50.verticalSpace,
              LiveWellButton(
                  label:
                      Get.find<HomeController>().localization.backToDashboard!,
                  color: const Color(0xFF8F01DF),
                  textColor: Colors.white,
                  onPressed: () {
                    AppNavigator.popUntil(routeName: AppPages.home);
                  }),
            ],
          ),
        ));
  }
}
