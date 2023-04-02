import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:livewell/feature/nutrico/presentation/controller/nutrico_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class NutriCoScreen extends StatelessWidget {
  NutriCoScreen({super.key});

  final NutriCoController controller = Get.put(NutriCoController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: 'NutriCo',
      trailing: InkWell(
          child: const Icon(
            Icons.info_outline,
            color: Color(0xFF505050),
          ),
          onTap: () {}),
      beta: true,
      body: Expanded(
        child: Column(
          children: [
            24.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextFormField(
                controller: controller.foodDescription,
                maxLength: 150,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.foodDescription.text = "";
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Color(0xFFC1C1C1),
                      )),
                  hintText:
                      'Example : A medium sized ice tea with 25% sugar and konjac jelly',
                  hintStyle: TextStyle(
                      color: const Color(0xFFC1C1C1),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
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
            LiveWellButton(
              label: 'Submit',
              color: const Color(0xFFDDF235),
              onPressed: () {
                controller.postData();
              },
            ),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }
}
