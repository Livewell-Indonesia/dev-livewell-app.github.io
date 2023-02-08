import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/nutriscore/presentation/pages/nutriscore_detail_screen.dart';
import 'package:livewell/widgets/banner/nutriscore_banner.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class NutriScoreScreen extends StatelessWidget {
  const NutriScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'NutriScore Details'.tr,
        backgroundColor: Colors.white,
        body: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  24.verticalSpace,
                  const NutriscoreBanner(value: 75),
                  24.verticalSpace,
                  //create a grid with item nutriscoredetailitem with length 10
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.3,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: const NutriScoreDetailItem(),
                        onTap: () {
                          Get.to(() => const NutriScoreDetailsScreen());
                        },
                      );
                    },
                    itemCount: 40,
                  ),
                  32.verticalSpace,
                ],
              ),
            ),
          ),
        ));
  }
}

class NutriScoreDetailItem extends StatelessWidget {
  const NutriScoreDetailItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calories',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp),
          ),
          8.verticalSpace,
          Row(
            children: [
              Text(
                '8/10',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp),
              ),
              8.horizontalSpace,
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF091ED9),
                    borderRadius: BorderRadius.circular(100)),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                child: Text(
                  'Optimal',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              )
            ],
          ),
        ],
      ),
    );
  }
}
