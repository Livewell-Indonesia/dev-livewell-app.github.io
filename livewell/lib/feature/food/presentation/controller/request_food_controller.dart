import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/domain/usecase/post_food_request.dart';
import 'package:livewell/routes/app_navigator.dart';

class RequestFoodController extends GetxController {
  var foodNameText = TextEditingController();

  String foodName = "";

  @override
  void onInit() {
    super.onInit();
    foodName = Get.arguments;
    foodNameText.text = foodName;
  }

  void postRequestFood() async {
    PostRequestFood foodRequest = PostRequestFood.instance();
    EasyLoading.show();
    final result = await foodRequest(foodName);
    EasyLoading.dismiss();
    result.fold((l) {}, (r) {
      AppNavigator.push(routeName: AppPages.requestFoodSuccess);
    });
  }
}
