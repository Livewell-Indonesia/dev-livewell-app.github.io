import 'dart:developer';

import 'package:get/get.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/dashboard/data/model/user_model.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_user.dart';
import 'package:livewell/routes/app_navigator.dart';

class DashboardController extends GetxController {
  GetUser getUser = GetUser.instance();
  Rx<UserModel> user = UserModel().obs;
  @override
  void onInit() {
    getUsersData();
    super.onInit();
  }

  void getUsersData() async {
    var result = await getUser(NoParams());
    result.fold((l) => print(l), (r) {
      user.value = r;
      inspect(r);
      if (r.onboardingQuestionnaire == null) {
        AppNavigator.push(routeName: AppPages.questionnaire);
      }
    });
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
