import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class FinishQuestionnaireScreen extends StatelessWidget {
  const FinishQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDF235),
      body: Column(
        children: [
          const Spacer(),
          Center(
              child: SizedBox(
                  width: 280.w,
                  height: 296.h,
                  child: SvgPicture.asset(Constant.imgFinishQuestionnaireSVG))),
          50.verticalSpace,
          Text(
            'You are ready to go!',
            style: TextStyle(
                color: const Color(0xFF171433),
                fontSize: 24.sp,
                fontWeight: FontWeight.w600),
          ),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).r,
            child: Text(
              'Thanks for taking your time to create account with us. Let\'s start your wellness Journey',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xFF171433).withOpacity(0.7),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          80.verticalSpace,
          LiveWellButton(
              label: 'Get Started!',
              color: const Color(0xFF8F01DF),
              textColor: Colors.white,
              onPressed: () {
                // Navigator.pushNamed(context, '/home');
              }),
          65.verticalSpace,
        ],
      ),
    );
  }
}
