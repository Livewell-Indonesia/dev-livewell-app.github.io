import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/base/usecase.dart';
import '../../domain/usecase/get_food_history.dart';

class AddMealController extends GetxController {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  var state = SearchState.initial.obs;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        state.value = SearchState.searching;
      } else {
        state.value = SearchState.initial;
      }
    });
    getFoodsHistory();
  }

  void onTapSearchBar() {
    state.value = SearchState.searching;
  }

  void getFoodsHistory() async {
    GetFoodHistory instance = GetFoodHistory.instance();
    final result = await instance.call(NoParams());
    result.fold((l) => print(l), (r) => print(r.foods?.length ?? 0));
  }
}

enum SearchState {
  initial,
  searching,
  searchingWithResults,
}
