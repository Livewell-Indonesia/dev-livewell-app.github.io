import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

import '../../core/constant/constant.dart';
import '../../routes/app_navigator.dart';

class SuccessChangePasswordDialog extends StatelessWidget {
  const SuccessChangePasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200).r,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        width: 305.w,
        height: 509.h,
        decoration: BoxDecoration(
          color: const Color(0xFFDDF235),
          borderRadius: BorderRadius.circular(200).r,
        ),
        child: Column(
          children: [
            40.verticalSpace,
            Container(
              width: 220.w,
              height: 220.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF000000).withOpacity(0.1),
                  width: 20.w,
                ),
              ),
              child: Image.asset(
                Constant.icKey,
                scale: 1.15,
              ),
            ),
            24.verticalSpace,
            Text(
              'Your Password has been reset!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: const Color(0xFF171433),
                  fontWeight: FontWeight.w600,
                  height: 1.3),
            ),
            26.verticalSpace,
            LiveWellButton(
              label: 'Done',
              color: const Color(0xFF8F01DF),
              onPressed: () {
                AppNavigator.popUntil(routeName: AppPages.login);
              },
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
