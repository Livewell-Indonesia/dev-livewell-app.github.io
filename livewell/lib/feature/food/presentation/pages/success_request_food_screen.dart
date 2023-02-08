import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

import '../../../../widgets/buttons/livewell_button.dart';

class SuccessRequestFoodScreen extends StatelessWidget {
  const SuccessRequestFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: "Food Request Completed".tr,
        body: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thank You!'.tr,
                style: TextStyle(
                    color: const Color(0xFF171433),
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600),
              ),
              30.verticalSpace,
              Text(
                'Our team is working on your request.'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFF171433).withOpacity(0.8),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500),
              ),
              50.verticalSpace,
              LiveWellButton(
                  label: 'Back To Dashboard'.tr,
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
