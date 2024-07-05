import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_asset_model.dart';
import 'package:livewell/feature/nutrico/presentation/controller/nutrico_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class NutriCoScreen extends StatefulWidget {
  NutriCoScreen({super.key});

  @override
  State<NutriCoScreen> createState() => _NutriCoScreenState();
}

class _NutriCoScreenState extends State<NutriCoScreen> {
  final NutriCoController controller = Get.put(NutriCoController());

  @override
  void initState() {
    controller.trackEvent(LivewellNutricoEvent.describeFoodPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      onBack: () {
        Get.back();
        controller.trackEvent(LivewellNutricoEvent.describeFoodPageBackButton);
      },
      title: 'NutriCo',
      trailing: InkWell(
          child: const Icon(
            Icons.info_outline,
            color: Color(0xFF505050),
          ),
          onTap: () {
            if (controller.nutricoAssets.value != null) {
              controller.trackEvent(LivewellNutricoEvent.describeFoodPageInformationButton);
              showModalBottomSheet<dynamic>(
                  context: context,
                  isScrollControlled: true,
                  shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                      const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                  builder: (context) {
                    return Obx(() {
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                        height: 0.85.sh,
                        child: NutricoAssetsPopupWidget(asset: controller.nutricoAssets.value!),
                      );
                    });
                  });
            }
          }),
      beta: false,
      body: Expanded(
        child: Column(
          children: [
            24.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextFormField(
                controller: controller.foodDescription,
                maxLength: 150,
                style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.foodDescription.text = "";
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Color(0xFFC1C1C1),
                      )),
                  hintText: 'Example : A medium sized ice tea with 25% sugar and konjac jelly',
                  hintStyle: TextStyle(color: const Color(0xFFC1C1C1), fontSize: 16.sp, fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: const Color(0xFFDDF235),
                      width: 2.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: const Color(0xFFDDF235),
                      width: 2.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: const Color(0xFFDDF235),
                      width: 2.w,
                    ),
                  ),
                ),
                maxLines: 5,
              ),
            ),
            const Spacer(),
            Obx(() {
              return LiveWellButton(
                label: 'Submit',
                color: const Color(0xFFDDF235),
                onPressed: controller.buttonEnabled.value
                    ? () {
                        controller.trackEvent(LivewellNutricoEvent.describeFoodPageSubmitButton);
                        controller.postData();
                      }
                    : null,
              );
            }),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class NutricoAssetsPopupWidget extends StatelessWidget {
  final NutricoAsset asset;
  const NutricoAssetsPopupWidget({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        20.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              Text('Info', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        24.verticalSpace,
        Text(
          asset.nutrico?.title ?? "",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        16.verticalSpace,
        Text(asset.nutrico?.subTitle ?? "",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF808080),
            )),
        24.verticalSpace,
        Expanded(
          child: ListView(
            children: [
              generateAsset(asset.nutrico?.example1SubHeader ?? "", asset.nutrico?.example1Description ?? ""),
              24.verticalSpace,
              generateAsset(asset.nutrico?.example2SubHeader ?? "", asset.nutrico?.example2Description ?? ""),
              24.verticalSpace,
              generateAsset(asset.nutrico?.example3SubHeader ?? "", asset.nutrico?.example3Description ?? ""),
              24.verticalSpace,
              LiveWellButton(
                label: 'Start Now',
                color: const Color(0xFFDDF235),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        )
      ]),
    );
  }

  Column generateAsset(String header, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Example',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        16.verticalSpace,
        Text(
          header,
          style: TextStyle(color: const Color(0xFF808080), fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        24.verticalSpace,
        NutricoPoupDescriptionWidget(
          text: desc,
        )
      ],
    );
  }
}

class NutricoPoupDescriptionWidget extends StatelessWidget {
  final String text;
  const NutricoPoupDescriptionWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(color: const Color(0xFFF1F1F1), borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Food Description',
              style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            18.verticalSpace,
            Container(
              height: 130.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFDDF235),
                    width: 2.w,
                  )),
              child: Text(
                text,
                style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ));
  }
}
