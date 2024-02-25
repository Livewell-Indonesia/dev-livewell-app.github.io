import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/nutrico/presentation/controller/nutricoplus_controller.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            40.verticalSpace,
            Obx(() {
              if (controller.imageUrl.value.isNotEmpty) {
                return const _ImageContainer(
                  imageUrl: "https://assets.unileversolutions.com/recipes-v2/242794.jpg",
                );
              } else {
                return Container();
              }
            }),
            32.verticalSpace,
            Obx(() {
              if (controller.foodName.value.isNotEmpty) {
                return Text(
                  controller.foodName.value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF171433),
                    fontWeight: FontWeight.w600,
                  ),
                );
              } else {
                return Container();
              }
            }),
            const Spacer(),
            CircularProgressIndicator(
              backgroundColor: Color(0xFF808080).withOpacity(0.25),
              color: const Color(0xFF8F01DF),
            ),
            24.verticalSpace,
            Obx(() {
              return Text(
                controller.state.value.title(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF171433),
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
            8.verticalSpace,
            Obx(() {
              return Text(
                controller.state.value.subtitle(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF171433),
                ),
              );
            }),
            30.verticalSpace,
          ],
        ),
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
