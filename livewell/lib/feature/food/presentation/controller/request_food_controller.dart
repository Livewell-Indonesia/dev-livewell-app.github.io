import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/food/domain/usecase/post_food_request.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/core/base/base_controller.dart';

class RequestFoodController extends BaseController {
  var foodNameText = TextEditingController();

  String foodName = "";

  @override
  void onInit() {
    super.onInit();
    foodName = Get.arguments;
    foodNameText.text = foodName;
    trackEvent(LivewellMealLogEvent.mealLogPageRequestFoodPage);
  }

  void postRequestFood() async {
    PostRequestFood foodRequest = PostRequestFood.instance();
    EasyLoading.show();
    final result = await foodRequest(foodName);
    EasyLoading.dismiss();
    result.fold((l) {}, (r) {
      trackEvent(LivewellMealLogEvent.mealLogPageRequestFoodPageSubmitButton);
      AppNavigator.push(routeName: AppPages.requestFoodSuccess);
    });
  }
}
