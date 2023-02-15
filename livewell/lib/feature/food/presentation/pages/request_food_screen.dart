import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/presentation/controller/request_food_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

class RequestFoodScreen extends StatelessWidget {
  RequestFoodScreen({Key? key}) : super(key: key);

  final controller = Get.put(RequestFoodController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: "Request Food".tr,
        body: Expanded(
          child: Column(
            children: [
              40.verticalSpace,
              LiveWellTextField(
                  controller: controller.foodNameText,
                  hintText: "Food Name".tr,
                  labelText: "Food Name".tr,
                  errorText: null,
                  obscureText: false),
              const Spacer(),
              LiveWellButton(
                  label: 'Submit'.tr,
                  color: const Color(0xFF8F01DF),
                  textColor: Colors.white,
                  onPressed: () {
                    controller.postRequestFood();
                  }),
              20.verticalSpace,
            ],
          ),
        ));
  }
}
