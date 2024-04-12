import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/nutrico/presentation/controller/nutricoplus_controller.dart';
import 'package:lottie/lottie.dart';

class NutricoPlusLoadingScreen extends StatefulWidget {
  const NutricoPlusLoadingScreen({super.key});

  @override
  State<NutricoPlusLoadingScreen> createState() => _NutricoPlusLoadingScreenState();
}

class _NutricoPlusLoadingScreenState extends State<NutricoPlusLoadingScreen> {
  NutricoPlusController controller = Get.put(NutricoPlusController());

  @override
  void initState() {
    File image = Get.arguments;
    controller.searchFoodByImage(image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          65.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Obx(() {
              return Html(
                data: controller.title.value,
                style: {
                  "body": Style(
                    fontSize: FontSize(24.sp),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF171433),
                    textAlign: TextAlign.center,
                  ),
                },
              );
            }),
          ),
          64.verticalSpace,
          Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Container(
                width: 1.sw - 48.w,
                height: (1.sw - 48.w) / (16 / 9),
                color: const Color(0xFFF1F1F1),
                child: Obx(() {
                  return controller.assetUrl.value.isNotEmpty ? Lottie.network(controller.assetUrl.value) : const SizedBox();
                }),
              ),
            ),
          ),
          64.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Obx(() {
              return Html(
                data: controller.description.value,
                style: {
                  "body": Style(
                    fontSize: FontSize(16.sp),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF171433).withOpacity(0.7),
                    textAlign: TextAlign.center,
                  ),
                  "br": Style(
                    fontSize: FontSize(20.sp),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF171433).withOpacity(0.7),
                    textAlign: TextAlign.center,
                  )
                },
              );
            }),
          ),
          const Spacer(),
          CircularProgressIndicator(
            backgroundColor: const Color(0xFF808080).withOpacity(0.25),
            color: const Color(0xFF8F01DF),
          ),
          80.verticalSpace,
        ],
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  final String imageUrl;
  const _ImageContainer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: AspectRatio(
          aspectRatio: 1.sw / 200.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
