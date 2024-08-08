import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_health_fit/flutter_health_fit.dart';

import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/data/model/dashboard_model.dart';
import 'package:livewell/feature/dashboard/data/model/task_recommendation_model.dart';
import 'package:livewell/feature/dashboard/data/model/user_model.dart';
import 'package:livewell/feature/dashboard/domain/entity/feature_limit_entity.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_dashboard_data.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_feature_limit.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_user.dart';
import 'package:livewell/feature/dashboard/domain/usecase/post_mood.dart';
import 'package:livewell/feature/dashboard/presentation/controller/extension/dashboard_coachmark_controller.dart';
import 'package:livewell/feature/dashboard/presentation/controller/extension/dashboard_health_controller.dart';
import 'package:livewell/feature/dashboard/presentation/controller/extension/dashboard_task_card_controller.dart';
import 'package:livewell/feature/dashboard/presentation/enums/dashboard_coachmark_type.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card/task_card_widget.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:livewell/feature/diary/presentation/controller/user_diary_controller.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_activity_histories.dart';
import 'package:livewell/feature/food/domain/usecase/get_meal_history.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/mood/data/model/mood_detail_model.dart';
import 'package:livewell/feature/mood/domain/usecase/get_single_mood.dart';
import 'package:livewell/feature/mood/presentation/widget/mood_picker_widget.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';
import 'package:livewell/feature/nutriscore/domain/usecase/get_nutri_score.dart';
import 'package:livewell/feature/sleep/domain/usecase/get_sleep_list.dart';
import 'package:livewell/feature/sleep/presentation/controller/sleep_controller.dart';
import 'package:livewell/feature/streak/data/model/wellness_batch_data_model.dart';
import 'package:livewell/feature/streak/domain/usecase/get_total_streak.dart';
import 'package:livewell/feature/streak/domain/usecase/get_wellness_detail.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_calendar.dart';
import 'package:livewell/feature/water/data/model/water_list_model.dart';
import 'package:livewell/feature/water/domain/usecase/get_water_data.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../diary/domain/entity/user_meal_history_model.dart';
import 'dart:core';

List<String> streakDescriptionList = ["You're on a roll!", "Keep the streak alive!", "Keep it up!", "You're crushing it!", "You're on fire!"];

class DashboardController extends BaseController {
  GetUser getUser = GetUser.instance();
  GetMealHistory getMealHistory = GetMealHistory.instance();
  GetDashboardData getDashboardData = GetDashboardData.instance();
  GetNutriScore getNutriScore = GetNutriScore.instance();
  PostMood postMood = PostMood.instance();
  GetSingleMood getSingleMood = GetSingleMood.instance();
  GetSleepData getSleepData = GetSleepData.instance();
  GetFeatureLimit getFeatureLimit = GetFeatureLimit.instance();
  Rx<UserModel> user = UserModel().obs;
  Rx<DashboardModel> dashboard = DashboardModel().obs;
  ValueNotifier<double> valueNotifier = ValueNotifier(0.0);
  GetUserMealHistory getUserMealHistory = GetUserMealHistory.instance();
  RxList<MealHistoryModel> mealHistoryList = <MealHistoryModel>[].obs;
  Rx<double> waterConsumed = 0.0.obs;
  Rxn<MoodDetail> todayMood = Rxn<MoodDetail>();

  HealthFactory healthFactory = HealthFactory(useHealthConnectIfAvailable: true);
  FlutterHealthFit healthFit = FlutterHealthFit();

  Rx<NutriScoreModel> nutriScore = NutriScoreModel().obs;
  Rx<num> totalExercise = 0.obs;
  Rxn<FeatureLimitEntity> featureLimit = Rxn<FeatureLimitEntity>();
  Rx<int> numberOfStreaks = 0.obs;
  RxList<StreakCalendarItemModel> streakDates = <StreakCalendarItemModel>[].obs;
  Rx<int> todayProgress = 0.obs;
  Rx<String> streakDescription = ''.obs;
  Rx<int> wellnessScore = 0.obs;
  Rxn<WellnessData> wellnessData = Rxn<WellnessData>();
  Rx<String> wellnessTitle = 'Your wellness is in the low range. Check to see what you need to improve.'.obs;
  Rx<bool> showDoneRecommendation = false.obs;
  late TutorialCoachMark tutorialCoachMark;

  var types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_DEEP,
    HealthDataType.SLEEP_LIGHT,
    HealthDataType.SLEEP_REM,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_REM,
    HealthDataType.SLEEP_IN_BED,
    HealthDataType.SLEEP_OUT_OF_BED,
  ];

  var permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  RxList<TaskCardModel> taskCardModel = <TaskCardModel>[].obs;
  Rx<TaskRecommendationModel> taskRecommendationModel = TaskRecommendationModel().obs;
  Rx<bool> isLoadingTaskRecommendation = true.obs;

  // Coachmark Variables
  Rx<DashboardCoachmarkType> coachmarkType = DashboardCoachmarkType.nutricoPlus.obs;
  Rx<bool> isShowCoachmark = false.obs;

  void getTotalStreak() {
    final useCase = GetTotalStreak.instance();
    useCase(NoParams()).then((value) {
      value.fold((l) {
        Log.error(l);
        streakDescription.value = 'Start your streak!';
        numberOfStreaks.value = 0;
      }, (r) {
        numberOfStreaks.value = r;
        if (numberOfStreaks.value != 0) {
          final shuffled = streakDescriptionList..shuffle();
          streakDescription.value = shuffled.first;
        } else {
          streakDescription.value = 'Start your streak!';
        }
      });
    });
  }

  void getTodayWellnessData() {
    numberOfStreaks.value = 0;
    todayProgress.value = 0;
    streakDates.clear();
    wellnessScore.value = 0;
    final usecase = GetWellnessDetail.instance();
    usecase(DateTime.now()).then((value) {
      value.fold((l) {
        Log.error(l);
      }, (r) {
        if (r.response == null) return;
        wellnessData.value = r.response?.displayData;
        if (r.response?.details != null && r.response?.details?.activity?.value != 0) {
          todayProgress.value++;
        }
        if (r.response?.details != null && r.response?.details?.hydration?.value != 0) {
          todayProgress.value++;
        }
        if (r.response?.details != null && r.response?.details?.calories?.value != 0) {
          todayProgress.value++;
        }
        if (r.response?.details != null && r.response?.details?.sleep?.value != 0) {
          todayProgress.value++;
        }
        if (r.response?.details != null && r.response?.details?.mood?.value != 0) {
          todayProgress.value++;
        }
        wellnessScore.value = r.response?.displayData?.totalScore ?? 0;
        getTaskRecommendation();
      });
    });
  }

  List<DateTime> generateWeekStartingFromMonday() {
    List<DateTime> dates = [];
    DateTime now = DateTime.now();
    int daysSinceLastMonday = (now.weekday - DateTime.monday + 7) % 7;
    DateTime lastMonday = now.subtract(Duration(days: daysSinceLastMonday));

    for (int i = 0; i < 7; i++) {
      dates.add(lastMonday.add(Duration(days: i)));
    }

    return dates;
  }

  bool checkIfNutricoAlreadyLimit() {
    if (featureLimit.value != null) {
      var data = featureLimit.value!.featureLimits.firstWhere((element) => element.featureName == 'NUTRICO_PLUS');
      return data.currentUsage > data.currentLimit;
    }
    return false;
  }

  void fetchHealthData() async {
    if (await isHealthAuthorized()) {
      fetchHealthDataFromLocal();
      initiateCoachmark();
    } else {
      fetchHealthDataFromLocal();
      initiateCoachmark();
    }
  }

  void showCoachmark() {
    final HomeController homeController = Get.find();
    homeController.showCoachmark();
  }

  void getSingleMoodData() async {
    final result = await getSingleMood.call(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    result.fold((l) {
      if (l.message!.contains("404")) {
        todayMood.value = null;
      }
    }, (r) {
      todayMood.value = r;
    });
  }

  void onMoodSelected(MoodType type) async {
    EasyLoading.show();
    final result = await postMood.call(PostMoodParams(value: type.value()));
    EasyLoading.dismiss();
    result.fold((l) {
      Log.error(l);
    }, (r) {
      getSingleMoodData();
      if (Get.isRegistered<UserDiaryController>()) {
        Get.find<UserDiaryController>().refreshList();
      }
    });
  }

  Future<void> getExerciseHistorydata() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59, 0, 0);
    GetActivityHistory getExerciseList = GetActivityHistory.instance();
    final result = await getExerciseList.call(GetActivityHistoryParam(type: ['ACTIVE_ENERGY_BURNED'], dateFrom: currentDate, dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      num total = 0.0;
      if (r.first.details != null) {
        for (var data in r.first.details!) {
          total += data.value ?? 0;
        }
      }

      totalExercise.value = total.round();
    });
  }

  @override
  void onInit() {
    todayProgress.value = 0;
    getUsersData();
    getDashBoardData();
    getMealHistories();
    getWaterData();
    getSingleMoodData();
    getFeatureLimitData();
    getTodayWellnessData();
    getTotalStreak();
    super.onInit();
  }

  Future<void> getFeatureLimitData() async {
    final result = await getFeatureLimit.call(NoParams());
    result.fold((l) {
      Log.error(l);
    }, (r) {
      featureLimit.value = r;
    });
  }

  Future<void> onRefresh() async {
    fetchHealthData();
    getDashBoardData();
    getMealHistories();
    getWaterData();
    getSingleMoodData();
    getFeatureLimitData();
    getTodayWellnessData();
    getTotalStreak();
    if (Get.isRegistered<SleepController>()) {
      Get.find<SleepController>().refreshList();
    }
  }

  void getNutriscoreData() async {
    final result = await getNutriScore.call(NoParams());
    result.fold((l) {
      Log.error(l);
    }, (r) {
      nutriScore.value = r;
    });
  }

  void getWaterData() async {
    // mock api call for 2 s
    GetWaterData instance = GetWaterData.instance();
    final result = await instance.call(NoParams());
    result.fold((l) {
      Log.error(l);
    }, (r) {
      if (r.response != null) {
        var consumed = r.response?.firstWhere((element) => element.recordAt == DateFormat('yyyy-MM-dd').format(DateTime.now()), orElse: () => WaterModel(recordAt: '', value: 0)).value ?? 0;
        waterConsumed.value = consumed.toDouble();
      }
    });
  }

  void getMealHistories() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
    final result = await getUserMealHistory(UserMealHistoryParams(filter: Filter(endDate: currentDate, startDate: currentDate.add(const Duration(seconds: 86399)))));
    result.fold((l) {}, (r) {
      mealHistoryList.value = r.response ?? [];
    });
  }

  Future<void> getUsersData() async {
    var result = await getUser(NoParams());
    result.fold((l) => Log.error(l), (r) async {
      user.value = r;
      await SharedPref.saveEmail(r.email ?? '');
      await SharedPref.saveBirthDate(r.birthDate ?? '');
      await SharedPref.saveGender(r.gender ?? '');
      await SharedPref.saveName('${r.firstName} ${r.lastName}');
      if (r.onboardingQuestionnaire == null && Get.currentRoute == AppPages.home) {
        Future.delayed(const Duration(milliseconds: 800), () {
          AppNavigator.push(routeName: AppPages.questionnaire);
        });
      } else {
        fetchHealthData();
      }
    });
  }

  void getDashBoardData() async {
    var result = await getDashboardData(NoParams());
    result.fold((l) => Log.error(l), (r) {
      dashboard.value = r;
      if ((dashboard.value.dashboard?.target ?? 0) == 0) {
        valueNotifier.value = 0;
      } else if ((dashboard.value.dashboard?.caloriesTaken ?? 0) == 0) {
        valueNotifier.value = 0;
      } else if ((dashboard.value.dashboard?.caloriesTaken ?? 0) >= (dashboard.value.dashboard?.target ?? 0)) {
        valueNotifier.value = 1;
      } else {
        valueNotifier.value = (dashboard.value.dashboard?.caloriesTaken ?? 0) / (dashboard.value.dashboard?.target ?? 0);
      }
    });
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return localization.morning!;
    }
    if (hour < 17) {
      return localization.afternoon!;
    }
    return localization.evening!;
  }

  Rx<double> getWeightPercentage() {
    var currentWeight = user.value.weight;
    var targetWeight = user.value.weightTarget;
    var percentage = 0.0.obs;

    if (user.value.weight == null || user.value.weight == 0) {
      return percentage;
    }
    if (user.value.weightTarget == null || user.value.weightTarget == 0) {
      return percentage;
    }
    if (currentWeight! > targetWeight!) {
      percentage.value = (1 - (currentWeight - targetWeight) / currentWeight);
    } else {
      percentage.value = (1 - (targetWeight - currentWeight) / currentWeight);
    }
    return percentage;
  }

  RxString remainingCalToShow() {
    var remaining = dashboard.value.dashboard?.caloriesLeft ?? 0;
    var remainingCal = remaining.toString().obs;
    if (remaining < 0) {
      remainingCal.value = '+ ${remaining * -1}';
    }
    return remainingCal;
  }

  Rx<bool> isCompleted(int index) {
    // cek user udah pernah makan atau belum
    if (mealHistoryList.isEmpty) {
      return false.obs;
    } else {
      for (var element in mealHistoryList) {
        if (element.mealType?.toLowerCase() == user.value.dailyJournal![index].name?.toLowerCase()) {
          var d1 = DateTime.parse(element.mealAt!);
          var d2 = DateTime.now();
          if (d1.day == d2.day && d1.month == d2.month && d1.year == d2.year) {
            return true.obs;
          } else {
            return false.obs;
          }
        }
      }
      return false.obs;
    }
  }

  Rx<num> totalCarbs() {
    var total = 0.0.obs;
    if (user.value.bmr == null) {
      return total;
    } else {
      var bmr = (user.value.bmr ?? 0) + totalExercise.value;
      total = ((0.5 * bmr) / 4).obs;
      return total;
    }
  }

  Rx<num> totalProtein() {
    var total = 0.0.obs;
    if (user.value.bmr == null) {
      return total;
    } else {
      var bmr = (user.value.bmr ?? 0) + totalExercise.value;
      total = ((0.2 * bmr) / 4).obs;
      return total;
    }
  }

  Rx<num> totalFat() {
    var total = 0.0.obs;
    if (user.value.bmr == null) {
      return total;
    } else {
      var bmr = (user.value.bmr ?? 0) + totalExercise.value;
      total = ((0.3 * bmr) / 9).obs;
      return total;
    }
  }
}
