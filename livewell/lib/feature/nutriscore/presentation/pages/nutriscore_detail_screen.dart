import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class NutriScoreDetailsScreen extends StatelessWidget {
  const NutriScoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        backgroundColor: Colors.white,
        title: 'NutriScore Details',
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                24.verticalSpace,
                Text(
                  'Protein',
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                24.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Score : ',
                      style: TextStyle(
                          color: const Color(0xFF171433),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    Text(
                      '8/10',
                      style: TextStyle(
                          color: const Color(0xFF171433),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp),
                    ),
                    16.horizontalSpace,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF091ED9),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'Optimal',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF808080),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                24.verticalSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFEBEBEB))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 12,
                              )),
                          Text('January 2023',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: Color(0xFF171433),
                              ))
                        ],
                      ),
                      const Divider(),
                      16.verticalSpace,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Last 7 Days',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      16.verticalSpace,
                      Chart(
                        state: ChartState<void>(
                            data: ChartData.fromList(
                              [10, 7, 8, 2, 9, 4, 6]
                                  .map((e) => ChartItem<void>(e.toDouble()))
                                  .toList(),
                              axisMax: 11,
                            ),
                            itemOptions: BarItemOptions(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              barItemBuilder: (_) => BarItem(
                                  color: const Color(0xFFDDF235),
                                  radius: BorderRadius.circular(20)),
                              maxBarWidth: 1.0,
                            ),
                            backgroundDecorations: [
                              GridDecoration(
                                  verticalAxisStep: 5,
                                  showVerticalGrid: false,
                                  horizontalAxisStep: 5,
                                  gridColor: const Color(0xFFEBEBEB),
                                  horizontalLegendPosition:
                                      HorizontalLegendPosition.start,
                                  showHorizontalValues: true,
                                  textStyle: TextStyle(
                                      color: const Color(0xFF505050),
                                      fontSize: 12.sp)),
                            ],
                            foregroundDecorations: []),
                      ),
                    ],
                  ),
                ),
                32.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About Protein',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                8.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Protein is a vital nutrient that helps build and repair muscles, boost the immune system, and aid in weight management. You can find it in delicious foods like meat, fish, eggs, dairy, beans, and nuts. Mix it up and try different sources to make sure you\'re getting all the nutrients your body needs.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF808080),
                    ),
                  ),
                ),
                24.verticalSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Disclaimer',
                        style: TextStyle(
                            color: const Color(0xFF171433),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      8.verticalSpace,
                      Text(
                        'Livewell nutritional data is for general fitness and wellness use. May contain inaccuracies. Consult a professional for personalized advice.',
                        style: TextStyle(
                            color: const Color(0xFF808080),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      100.verticalSpace,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
