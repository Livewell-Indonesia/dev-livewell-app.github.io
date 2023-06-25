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
      localization = languageController.localization.value;
      inspect(localization);
    } else {
      LanguageController languageController = Get.put(LanguageController());
      localization = languageController.localization.value;
    }
  }

  Future<void> changeLocalization(AvailableLanguage lang) async {
    if (Get.isRegistered<LanguageController>()) {
      LanguageController languageController = Get.find<LanguageController>();
      languageController.changeLocalization(lang);
    } else {
      LanguageController languageController = Get.put(LanguageController());
      languageController.changeLocalization(lang);
      update();
    }
  }

  AvailableLanguage? LanguagefromString(String? locale) {
    if (locale == null) return null;
    return AvailableLanguage.values.firstWhere(
        (element) => element.languageCode == locale,
        orElse: () => AvailableLanguage.en);
  }

  AvailableLanguage? LanguagefromLocale(String? locale) {
    if (locale == null) return null;
    return AvailableLanguage.values.firstWhere(
        (element) => element.locale == locale,
        orElse: () => AvailableLanguage.en);
  }
}

class LanguageController extends GetxController {
  Rx<Localization> parentLocalization = Localization().obs;
  Rx<LocalizationKey> localization = LocalizationKey().obs;
  GetLocalizationData getLocalizationData = GetLocalizationData.instance();
  @override
  void onInit() {
    //getLocalizationDatas();
    super.onInit();
  }

  void getLocalizationDatas() async {
    final result = await getLocalizationData.call(NoParams());
    result.fold((l) {}, (r) {
      parentLocalization.value = r;
    });
  }

  Future<void> changeLocalization(AvailableLanguage lang) async {
    final result = await getLocalizationData.call(NoParams());
    result.fold((l) {}, (r) {
      parentLocalization.value = r;
      switch (lang) {
        case AvailableLanguage.en:
          localization.value = r.enUS!;
          break;
        case AvailableLanguage.id:
          localization.value = r.idID!;
          break;
      }
    });
  }

  AvailableLanguage? LanguagefromString(String? locale) {
    if (locale == null) return null;
    return AvailableLanguage.values.firstWhere(
        (element) => element.languageCode == locale,
        orElse: () => AvailableLanguage.en);
  }

  AvailableLanguage? LanguagefromLocale(String? locale) {
    if (locale == null) return null;
    return AvailableLanguage.values.firstWhere(
        (element) => element.locale == locale,
        orElse: () => AvailableLanguage.en);
  }
}

enum AvailableLanguage { en, id }

extension AvailableLanguageExtension on AvailableLanguage {
  String get languageCode => ['en', 'id'][index];
  String get countryCode => ['US', 'ID'][index];
  String get locale => '${languageCode}_$countryCode';
  String get title {
    switch (this) {
      case AvailableLanguage.en:
        return 'English';
      case AvailableLanguage.id:
        return 'Indonesia';
    }
  }
}
