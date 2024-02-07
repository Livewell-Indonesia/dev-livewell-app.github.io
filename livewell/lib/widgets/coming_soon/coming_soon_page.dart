import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ComingSoonPage extends StatelessWidget {
  final String imageAsset;
  final String description;
  const ComingSoonPage(
      {super.key, required this.imageAsset, required this.description});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 1.sw,
          height: 306.h,
          decoration: BoxDecoration(
            color: const Color(0xFFDDF235),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            24.verticalSpace,
            Text('Coming Soon'.tr,
                style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF171433))),
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF808080),
                      fontWeight: FontWeight.w500,
                      height: 20.sp / 14.sp)),
            ),
            60.verticalSpace,
            SizedBox(
              child: Stack(
                children: [
                  Image.asset(
                    imageAsset,
                    width: 264.w,
                    height: 424.73.h,
                  ),
                ],
              ),
            ),
            102.verticalSpace,
          ],
        ),
      ],
    );
  }
}
