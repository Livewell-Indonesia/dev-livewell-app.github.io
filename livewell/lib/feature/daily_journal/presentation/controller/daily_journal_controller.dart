import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/daily_journal/domain/usecase/post_daily_journal.dart';
import 'package:livewell/feature/dashboard/data/model/user_model.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/routes/app_navigator.dart';

class DailyJournalController extends GetxController {
  Rxn<DateTime> breakfastTime = Rxn<DateTime>();
  Rxn<DateTime> lunchTime = Rxn<DateTime>();
  Rxn<DateTime> dinnerTime = Rxn<DateTime>();

  PostDailyJournal postDailyJournal = PostDailyJournal.getInstance();

  @override
  void onInit() {
    if (Get.isRegistered<DashboardController>()) {
      var user = Get.find<DashboardController>().user.value;
      if (user.dailyJournal != null) {
        DailyJournal? breakfastTemp = user.dailyJournal!.firstWhereOrNull(
            (element) =>
                element.name?.toUpperCase() == 'Breakfast'.toUpperCase());
        breakfastTime.value = breakfastTemp != null
            ? DateFormat('HH:mm').parse(breakfastTemp.time!)
            : null;
        DailyJournal? lunchTemp = user.dailyJournal!.firstWhereOrNull(
            (element) => element.name?.toUpperCase() == 'Lunch'.toUpperCase());
        lunchTime.value = lunchTemp == null
            ? null
            : DateFormat('HH:mm').parse(lunchTemp.time!);
        DailyJournal? dinnerTemp = user.dailyJournal!.firstWhereOrNull(
            (element) => element.name?.toUpperCase() == 'Dinner'.toUpperCase());
        dinnerTime.value = dinnerTemp == null
            ? null
            : DateFormat('HH:mm').parse(dinnerTemp.time!);
      }
    }
    super.onInit();
  }

  void setTime() async {
    await EasyLoading.show();
    final result = await postDailyJournal(DailyJournalParams.asParams(
        breakfastTime.value != null
            ? DateFormat('HH:mm').format(breakfastTime.value!)
            : null,
        lunchTime.value != null
            ? DateFormat('HH:mm').format(lunchTime.value!).toString()
            : null,
        dinnerTime.value != null
            ? DateFormat('HH:mm').format(dinnerTime.value!).toString()
            : null));
    await EasyLoading.dismiss();
    result.fold((l) => Get.snackbar('Error', l.toString()), (r) {
      AppNavigator.pushAndRemove(routeName: AppPages.home);
      Get.snackbar('Success', 'Daily Journal Updated');
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().getUsersData();
      }
    });
  }
}
