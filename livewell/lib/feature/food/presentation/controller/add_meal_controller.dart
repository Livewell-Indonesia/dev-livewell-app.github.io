import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/domain/usecase/post_search_food.dart';

import '../../../../core/base/usecase.dart';
import '../../domain/usecase/get_food_history.dart';

class AddMealController extends GetxController
    with GetTickerProviderStateMixin {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  var state = SearchState.initial.obs;
  var history = <MealHistoryModel>[].obs;
  var results = <Foods>[].obs;
  var filteredResult = <Foods>[].obs;
  var localFnBResult = <Foods>[].obs;
  var brandNameResult = <Foods>[].obs;

  PostSearchFood searchFood = PostSearchFood.instance();
  GetUserMealHistory mealHistory = GetUserMealHistory.instance();
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        state.value = SearchState.searching;
      } else {
        if (textEditingController.text.isEmpty) {
          state.value = SearchState.initial;
        } else {
          state.value = SearchState.searchingWithResults;
        }
      }
    });
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      onTabChange(tabController.index);
    });
    textEditingController.addListener(() {
      update();
    });
    getFoodsHistory();
  }

  void onTapSearchBar() {
    state.value = SearchState.searching;
  }

  void onTabChange(int index) {
    switch (index) {
      case 0:
        results = results;
        break;
      case 1:
        filteredResult = results;
        break;
      case 2:
        brandNameResult.value = results
            .where((p0) =>
                p0.brandName?.contains(textEditingController.text) ?? false)
            .toList();
        break;
    }
  }

  void getFoodsHistory() async {
    final result = await mealHistory.call(UserMealHistoryParams());
    result.fold((l) => print(l), (r) {
      inspect(r.response);
      Log.info("total history ${r.response?.length}");
      history.value = r.response ?? [];
    });
  }

  void doSearchFood() async {
    state.value = SearchState.searchingWithResults;
    final result = await searchFood
        .call(SearchFoodParams(query: textEditingController.text));
    result.fold((l) {
      inspect(l);
    }, (r) {
      results.value = r.foods ?? [];
    });
  }
}

enum SearchState {
  initial,
  searching,
  searchingWithResults,
}
