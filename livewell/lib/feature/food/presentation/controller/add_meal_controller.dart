import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/domain/usecase/post_search_food.dart';

import '../../../../core/base/usecase.dart';
import '../../domain/usecase/get_food_history.dart';

class AddMealController extends GetxController {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  var state = SearchState.initial.obs;
  var history = <Foods>[].obs;
  var results = <Foods>[].obs;

  PostSearchFood searchFood = PostSearchFood.instance();

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
    getFoodsHistory();
    print("andi ganteng ${Get.arguments}");
  }

  void onTapSearchBar() {
    state.value = SearchState.searching;
  }

  void getFoodsHistory() async {
    GetFoodHistory instance = GetFoodHistory.instance();
    final result = await instance.call(NoParams());
    result.fold((l) => print(l), (r) {
      Log.info("total history ${r.foods?.length}");
      history.value = r.foods ?? [];
    });
  }

  void doSearchFood() async {
    state.value = SearchState.searchingWithResults;
    final result = await searchFood
        .call(SearchFoodParams(query: textEditingController.text));
    result.fold((l) {
      Get.snackbar("Error", l.toString());
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
