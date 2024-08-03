import 'dart:developer';
import 'dart:math';
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/domain/usecase/post_search_food.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../../home/controller/home_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:livewell/core/base/base_controller.dart';

class AddMealController extends BaseController with GetTickerProviderStateMixin {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  var state = SearchStates.initial.obs;
  var history = <MealHistoryModel>[].obs;
  var results = <Foods>[].obs;
  var filteredResult = <Foods>[].obs;
  var localFnBResult = <Foods>[].obs;
  var brandNameResult = <Foods>[].obs;
  var addedFoods = <Foods>[].obs;
  var isLoading = false.obs;

  PostSearchFood searchFood = PostSearchFood.instance();
  GetUserMealHistory mealHistory = GetUserMealHistory.instance();
  late TabController tabController;

  var caloriesRange = const RangeValues(0, 0).obs;
  var fatRange = const RangeValues(0, 0).obs;
  var carbsRange = const RangeValues(0, 0).obs;
  var proteinRange = const RangeValues(0, 0).obs;

  Rx<bool> showRecommendationWidget = false.obs;

  late TutorialCoachMark tutorialCoachMark;

  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();

  void showTutorial(BuildContext context) async {
    var showCoachmark = await SharedPref.getShowCoachmarkFood();
    if (showCoachmark) {
      state.value = SearchStates.searchingWithResults;
      showRecommendationWidget.value = true;
      update();
      Future.delayed(const Duration(milliseconds: 200), () {
        tutorialCoachMark.show(context: context);
      });
    }
  }

  void onFinishCoachmark() async {
    await SharedPref.saveShowCoachmarkFood(false);
  }

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        state.value = SearchStates.searchingWithResults;
        showRecommendationWidget.value = true;
        hitsSearcher.query(textEditingController.text);
      } else {
        if (textEditingController.text.isEmpty) {
          state.value = SearchStates.initial;
        } else {
          state.value = SearchStates.searchingWithResults;
          showRecommendationWidget.value = true;
          update();
        }
      }
    });
    searchPage.listen((event) {
      if (event.pageKey == 0) {
        pagingController.refresh();
      }
      pagingController.appendPage(event.items, event.nextPageKey);
    }).onError((error) {
      pagingController.error = error;
      Log.error(error);
    });
    pagingController.addPageRequestListener((pageKey) {
      hitsSearcher.applyState((state) => state.copyWith(page: pageKey));
    });
    hitsSearcher.connectFilterState(_filterState);
    _filterState.filters.listen((event) => pagingController.refresh());

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      onTabChange(tabController.index);
    });
    textEditingController.addListener(() {
      update();
    });
    getFoodsHistory();
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().getAppConfig();
    }
  }

  void onTapSearchBar() {
    state.value = SearchStates.searching;
    showRecommendationWidget.value = true;
  }

  void onDoneInput() {
    showRecommendationWidget.value = true;
  }

  void onRecommendationWidgetTapped() {
    state.value = SearchStates.searchingWithRecommendation;
    var user = Get.find<DashboardController>().user.value;
    var dashboardData = Get.find<DashboardController>().dashboard.value;
    if (user.onboardingQuestionnaire != null) {
      var goals = user.onboardingQuestionnaire!.targetImprovement;
      if (goals!.contains(GoalSelection.weightLoss.value())) {
        if (dashboardData.dashboard != null) {
          var calories = (dashboardData.dashboard?.caloriesTaken ?? 0);
          var totalCalories = (dashboardData.dashboard?.totalCalories ?? 0);
          var remainingCalories = totalCalories - calories;
          var remainingCaloriesMin = remainingCalories - 300;
          var fat = (dashboardData.dashboard?.totalFatsInG ?? 0);
          var recommendFat = ((0.3 * totalCalories) / 9);
          var remainingFat = recommendFat - fat;
          var remainingFatMin = 0;
          var fatMax = remainingFat < 22 ? remainingFat : 22;

          hitsSearcher.applyState((state) => state.copyWith(numericFilters: ['calories:0 TO $remainingCaloriesMin', 'fat:$remainingFatMin TO $fatMax']));
        }
      } else {
        var bmr = (dashboardData.dashboard?.totalCalories ?? 0);
        var userFat = (dashboardData.dashboard?.totalFatsInG ?? 0);
        var recommendFat = ((0.3 * bmr) / 9);
        var remainingFat = recommendFat - userFat;
        var remainingFatMin = max(remainingFat, 22);
        hitsSearcher.applyState((state) => state.copyWith(numericFilters: ['protein:5 TO 150', 'fat: 0 to $remainingFatMin']));
      }
    }
  }

  void onTabChange(int index) {
    switch (index) {
      case 0:
        _filterState.clear();
        break;
      case 1:
        filteredResult = results;
        break;
      case 2:
        facetList.toggle(textEditingController.text);
        break;
    }
  }

  void getFoodsHistory() async {
    final result = await mealHistory.call(UserMealHistoryParams());
    result.fold((l) {}, (r) {
      history.value = r.response ?? [];
    });
  }

  void onSubmitFilter() async {
    filterByFacets();
  }

  void doSearchFood() async {
    state.value = SearchStates.searchingWithResults;
    isLoading.value = true;
    final result = await searchFood.call(SearchFoodParams(query: textEditingController.text));
    isLoading.value = false;
    result.fold((l) {
      Log.error(l);
    }, (r) {
      results.value = r.foods ?? [];
    });
  }

  Rx<bool> isUpcScanActive() {
    if (Get.isRegistered<HomeController>()) {
      return Get.find<HomeController>().appConfigModel.value.upcSearch!.obs;
    } else {
      return false.obs;
    }
  }

  Rx<bool> checkAvailability(ScanType type) {
    return true.obs;
  }

  Rx<bool> isQuickAddActive() {
    if (Get.isRegistered<HomeController>()) {
      return true.obs;
    } else {
      return true.obs;
    }
  }

  Rx<bool> showScanMenu() {
    return true.obs;
  }

  Rx<bool> isScanMealActive() {
    if (Get.isRegistered<HomeController>()) {
      return Get.find<HomeController>().appConfigModel.value.scanMeal!.obs;
    } else {
      return false.obs;
    }
  }

  // algolia integration
  final hitsSearcher = HitsSearcher(
    applicationID: 'JTCO4LVZ9P',
    apiKey: '7604aab9adfbe627a8f4ccde0902e2e0',
    indexName: kReleaseMode ? 'prod_food_directory' : 'dev_food_directory',
  );
  final _filterState = FilterState();
  late final facetList = FacetList(searcher: hitsSearcher, filterState: _filterState, attribute: 'brand_name');

  Stream<SearchMetadata> get searchMetadata => hitsSearcher.responses.map((response) => SearchMetadata.fromResponse(response));
  Stream<HitsPage> get searchPage => hitsSearcher.responses.map(HitsPage.fromResponse);
  final PagingController<int, Foods> pagingController = PagingController(firstPageKey: 0);

  void filterByFacets() async {
    pagingController.refresh();
    hitsSearcher.applyState((state) {
      return state.copyWith(numericFilters: generateFilters());
    });
  }

  void resetFilter() {
    Get.back();
    pagingController.refresh();
    proteinRange.value = const RangeValues(0, 0);
    carbsRange.value = const RangeValues(0, 0);
    fatRange.value = const RangeValues(0, 0);
    caloriesRange.value = const RangeValues(0, 0);

    hitsSearcher.applyState((state) {
      return state.copyWith(numericFilters: []);
    });
  }

  // This function generates a list of filters from the range values of the range sliders
  List<String> generateFilters() {
    // Create an empty list to store the filters
    final filters = <String>[];

    // Calories
    // Check if either the start or end value of the range is greater than 0
    if (caloriesRange.value.start > 0 || caloriesRange.value.end > 0) {
      // Add the range to the list of filters
      filters.add('calories:${caloriesRange.value.start} TO ${caloriesRange.value.end}');
    }

    // Protein
    // Check if either the start or end value of the range is greater than 0
    if (proteinRange.value.start > 0 || proteinRange.value.end > 0) {
      // Add the range to the list of filters
      filters.add('protein:${proteinRange.value.start} TO ${proteinRange.value.end}');
    }

    // Carbs
    // Check if either the start or end value of the range is greater than 0
    if (carbsRange.value.start > 0 || carbsRange.value.end > 0) {
      // Add the range to the list of filters
      filters.add('carbs:${carbsRange.value.start} TO ${carbsRange.value.end}');
    }

    // Fat
    // Check if either the start or end value of the range is greater than 0
    if (fatRange.value.start > 0 || fatRange.value.end > 0) {
      // Add the range to the list of filters
      filters.add('fat:${fatRange.value.start} TO ${fatRange.value.end}');
    }

    // Return the list of filters
    return filters;
  }
}

enum SearchStates {
  initial,
  searching,
  searchingWithResults,
  searchingWithRecommendation,
}

class SearchMetadata {
  final int nbHits;

  const SearchMetadata(this.nbHits);

  factory SearchMetadata.fromResponse(SearchResponse response) => SearchMetadata(response.nbHits);
}

class HitsPage {
  const HitsPage(this.items, this.pageKey, this.nextPageKey);

  final List<Foods> items;
  final int pageKey;
  final int? nextPageKey;

  factory HitsPage.fromResponse(SearchResponse response) {
    final items = response.hits.map(Foods.fromJson).toList();
    final isLastPage = response.page >= response.nbPages;
    final nextPageKey = isLastPage ? null : response.page + 1;
    return HitsPage(items, response.page, nextPageKey);
  }
}

String sanitizeJson(String json) {
  return json.replaceAll('\"', '\\"');
}
