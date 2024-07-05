import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/domain/usecase/post_mood.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/mood/data/model/mood_model.dart';
import 'package:livewell/feature/mood/domain/usecase/get_mood_list.dart';
import 'package:livewell/feature/mood/presentation/widget/mood_picker_widget.dart';

class MoodScreenController extends BaseController {
  GetMoodList getMoodList = GetMoodList.instance();
  RxList<Mood> moodList = RxList<Mood>();
  Rxn<Mood> isMoodSelected = Rxn<Mood>();
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    var result = await getMoodList(14);
    result.fold((l) => Log.error(l), (r) {
      if (r.response != null) {
        moodList.addAll(r.response ?? []);
        isMoodSelected.value = moodList.firstWhereOrNull((element) {
          Log.colorGreen(element.recordAt ?? "");
          final moodDate = DateTime.parse(element.recordAt ?? "");
          return moodDate.day == DateTime.now().day &&
              moodDate.month == DateTime.now().month &&
              moodDate.year == DateTime.now().year;
        });
      }
    });
  }

  Mood? getMoodByDate(DateTime date) {
    return moodList.firstWhereOrNull((element) {
      Log.colorGreen(element.recordAt ?? "");
      final moodDate = DateTime.parse(element.recordAt ?? "");
      return moodDate.day == date.day &&
          moodDate.month == date.month &&
          moodDate.year == date.year;
    });
  }

  void postMoodData(MoodType type) async {
    PostMood postMood = PostMood.instance();
    EasyLoading.show();
    final result = await postMood(PostMoodParams(value: type.value()));
    result.fold((l) {}, (r) {
      moodList.clear();
      getData();
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().getSingleMoodData();
        trackEvent(LivewellMoodEvent.moodPageMoodButton,
            properties: {"mood": type.title()});
      }
    });
    EasyLoading.dismiss();
  }

  int getTotalMoodByType(int type) {
    return moodList.where((element) => element.value == type).length;
  }
}
