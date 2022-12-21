import 'dart:developer';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/domain/usecase/post_search_food.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import '../../../home/controller/home_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AddMealController extends GetxController
    with GetTickerProviderStateMixin {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  var state = SearchStates.initial.obs;
  var history = <MealHistoryModel>[].obs;
  var results = <Foods>[].obs;
  var filteredResult = <Foods>[].obs;
  var localFnBResult = <Foods>[].obs;
  var brandNameResult = <Foods>[].obs;
  var isLoading = false.obs;

  PostSearchFood searchFood = PostSearchFood.instance();
  GetUserMealHistory mealHistory = GetUserMealHistory.instance();
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        state.value = SearchStates.searching;
        hitsSearcher.query(textEditingController.text);
        pagingController.refresh();
      } else {
        if (textEditingController.text.isEmpty) {
          state.value = SearchStates.initial;
        } else {
          state.value = SearchStates.searchingWithResults;
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
    result.fold((l) => print(l), (r) {
      inspect(r.response);
      Log.info("total history ${r.response?.length}");
      history.value = r.response ?? [];
    });
  }

  void doSearchFood() async {
    state.value = SearchStates.searchingWithResults;
    isLoading.value = true;
    final result = await searchFood
        .call(SearchFoodParams(query: textEditingController.text));
    isLoading.value = false;
    result.fold((l) {
      inspect(l);
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
    if (type == ScanType.barcode) {
      return isUpcScanActive();
    } else if (type == ScanType.photo) {
      return isScanMealActive();
    } else {
      return false.obs;
    }
  }

  Rx<bool> isQuickAddActive() {
    if (Get.isRegistered<HomeController>()) {
      return Get.find<HomeController>().appConfigModel.value.quickAdd!.obs;
    } else {
      return false.obs;
    }
  }

  Rx<bool> showScanMenu() {
    return ((isQuickAddActive().value ||
            isUpcScanActive().value ||
            isScanMealActive().value))
        .obs;
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
  late final facetList = FacetList(
      searcher: hitsSearcher,
      filterState: _filterState,
      attribute: 'brand_name');

  Stream<SearchMetadata> get searchMetadata => hitsSearcher.responses
      .map((response) => SearchMetadata.fromResponse(response));
  Stream<HitsPage> get searchPage =>
      hitsSearcher.responses.map(HitsPage.fromResponse);
  final PagingController<int, Foods> pagingController =
      PagingController(firstPageKey: 0);
}

enum SearchStates {
  initial,
  searching,
  searchingWithResults,
}

class SearchMetadata {
  final int nbHits;

  const SearchMetadata(this.nbHits);

  factory SearchMetadata.fromResponse(SearchResponse response) =>
      SearchMetadata(response.nbHits);
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
