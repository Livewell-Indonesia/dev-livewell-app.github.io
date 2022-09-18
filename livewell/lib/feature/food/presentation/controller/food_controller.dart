import 'package:get/state_manager.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/food/domain/usecase/get_food_history.dart';

class FoodController extends GetxController {
  var firstValue = 0.0.obs;
  var secondValue = 0.0.obs;
  var thirdValue = 0.0.obs;

  @override
  void onReady() {
    firstValue.value = 50.0;
    secondValue.value = 40.0;
    thirdValue.value = 30.0;
  }

  @override
  void dispose() {
    firstValue.value = 0;
    secondValue.value = 0;
    thirdValue.value = 0;
    super.dispose();
  }
}
