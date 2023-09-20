import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/mood/data/model/mood_model.dart';
import 'package:livewell/feature/mood/domain/usecase/get_mood_list.dart';

class MoodScreenController extends BaseController {
  GetMoodList getMoodList = GetMoodList.instance();
  RxList<Mood> moodList = RxList<Mood>();
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    var result = await getMoodList(14);
    result.fold((l) => print(l), (r) {
      if (r.response != null) {
        moodList.addAll(r.response ?? []);
      }
    });
  }

  Mood? getMoodByDate(DateTime date) {
    return moodList.firstWhereOrNull((element) {
      Log.colorGreen(element);
      final moodDate = DateTime.parse(element.recordAt ?? "");
      return moodDate.day == date.day &&
          moodDate.month == date.month &&
          moodDate.year == date.year;
    });
  }

  int getTotalMoodByType(int type) {
    return moodList.where((element) => element.value == type).length;
  }
}
