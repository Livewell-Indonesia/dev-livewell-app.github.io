import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/nutriscore/presentation/controller/nutriscore_controller.dart';
import 'package:livewell/feature/nutriscore/presentation/pages/nutriscore_detail_screen.dart';
import 'package:livewell/feature/nutriscore/presentation/pages/nutriscore_score_detail_screen.dart';
import 'package:livewell/widgets/banner/nutriscore_banner.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class NutriScoreScreen extends StatefulWidget {
  const NutriScoreScreen({super.key});

  @override
  State<NutriScoreScreen> createState() => _NutriScoreScreenState();
}

class _NutriScoreScreenState extends State<NutriScoreScreen> {
  final NutriScoreController controller = Get.put(NutriScoreController());

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
                  Obx(() {
                    return InkWell(
                      onTap: () {
                        Get.to(() => NutriscoreScoreDetailScreen());
                      },
                      child: NutriscoreBanner(
                        value:
                            controller.nutriScore.value.totalPoints?.toInt() ??
                                0,
                        hideSeeDetails: true,
                      ),
                    );
                  }),
                  24.verticalSpace,
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.h,
                      crossAxisSpacing: 8.w,
                      childAspectRatio: 2.3,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Obx(() {
                          return NutriScoreDetailItem(
                            name: NutrientType.values[index].title(),
                            value: controller
                                    .getNutrientByType(
                                        NutrientType.values[index])
                                    ?.eaten ??
                                0,
                            score: controller
                                    .getNutrientByType(
                                        NutrientType.values[index])
                                    ?.optimizedNutrient ??
                                0,
                            unit: NutrientType.values[index].unit(),
                          );
                        }),
                        onTap: () {
                          controller
                              .onNutrientTapped(NutrientType.values[index]);
                        },
                      );
                    },
                    itemCount: NutrientType.values.length,
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
  final String name;
  final num value;
  final num score;
  final String unit;
  const NutriScoreDetailItem({
    super.key,
    required this.name,
    required this.value,
    required this.score,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEBEBEB)),
          borderRadius: BorderRadius.circular(24.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp),
          ),
          8.verticalSpace,
          Row(
            children: [
              Text(
                '${NumberFormat('0.0').format(value)}$unit',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp),
              ),
              8.horizontalSpace,
              Container(
                decoration: BoxDecoration(
                    color: getStatusFromScore().color(),
                    borderRadius: BorderRadius.circular(100)),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                child: Text(
                  getStatusFromScore().title(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
              )
            ],
          ),
        ],
      ),
    );
  }

  NutrientScoreStatus getStatusFromScore() {
    var scores = (value / score) * 100;
    if (scores > 140) {
      return NutrientScoreStatus.high;
    }
    if (scores >= 80) {
      return NutrientScoreStatus.optimal;
    }
    return NutrientScoreStatus.low;
  }
}

enum NutrientScoreStatus { low, optimal, high }

extension NutrientScoreStatusAtt on NutrientScoreStatus {
  // create getter for title
  String title() {
    switch (this) {
      case NutrientScoreStatus.low:
        return "Low";
      case NutrientScoreStatus.optimal:
        return "Optimal";
      case NutrientScoreStatus.high:
        return "High";
    }
  }

  Color color() {
    switch (this) {
      case NutrientScoreStatus.low:
        return const Color(0xff808080);
      case NutrientScoreStatus.optimal:
        return const Color(0xFF80A4A9);
      case NutrientScoreStatus.high:
        return const Color(0xFFFA6F6F);
    }
  }
}
