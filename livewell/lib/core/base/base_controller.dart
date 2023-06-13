import 'dart:developer';

import 'package:get/get.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/localization/localization_model.dart';
import 'package:livewell/feature/splash/domain/usecase/get_localization_data.dart';

class BaseController extends GetxController {
  LocalizationKey localization = LocalizationKey();
  @override
  void onInit() {
    getLocalizationDatas();
    super.onInit();
  }

  void getLocalizationDatas() async {
    if (Get.isRegistered<LanguageController>()) {
      LanguageController languageController = Get.find<LanguageController>();
      localization = languageController.parentLocalization.value.idID!;
      inspect(localization);
    } else {
      LanguageController languageController = Get.put(LanguageController());
      localization = languageController.parentLocalization.value.idID!;
    }
  }

  void changeLocalization() async {
    if (Get.isRegistered<LanguageController>()) {
      LanguageController languageController = Get.find<LanguageController>();
      localization = languageController.parentLocalization.value.enUS!;
    } else {
      LanguageController languageController = Get.put(LanguageController());
      localization = languageController.parentLocalization.value.enUS!;
      update();
    }
  }
}

class LanguageController extends GetxController {
  Rx<Localization> parentLocalization = Localization().obs;
  Rx<LocalizationKey> localization = LocalizationKey().obs;
  GetLocalizationData getLocalizationData = GetLocalizationData.instance();
  @override
  void onInit() {
    getLocalizationDatas();
    super.onInit();
  }

  void getLocalizationDatas() async {
    final result = await getLocalizationData.call(NoParams());
    result.fold((l) {}, (r) {
      parentLocalization.value = r;
    });
  }

  void changeLocalization() async {
    final result = await getLocalizationData.call(NoParams());
    result.fold((l) {}, (r) {
      parentLocalization.value = r;
    });
  }
}
