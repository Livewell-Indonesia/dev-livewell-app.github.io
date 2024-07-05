import 'dart:developer';

import 'package:get/get.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/core/localization/localization_model.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/splash/domain/usecase/get_localization_data.dart';

class BaseController extends FullLifeCycleController with FullLifeCycleMixin {
  LocalizationKey localization = LocalizationKey();
  LivewellTrackerService livewellTracker = Get.find();
  @override
  void onInit() {
    getLocalizationDatas();
    super.onInit();
  }

  void trackEvent(String event, {Map<String, dynamic>? properties}) {
    if (Get.isRegistered<DashboardController>()) {
      properties?['email'] = Get.find<DashboardController>().user.value.email;
      properties?['gender'] = Get.find<DashboardController>().user.value.gender;
      properties?['birth_date'] =
          Get.find<DashboardController>().user.value.birthDate;
      properties?['name'] =
          '${Get.find<DashboardController>().user.value.firstName ?? ' '} ${Get.find<DashboardController>().user.value.lastName ?? ''}';
      livewellTracker.trackEvent(event, properties: properties);
    } else {
      livewellTracker.trackEvent(event, properties: properties);
    }
  }

  void getLocalizationDatas() async {
    if (Get.isRegistered<LanguageController>()) {
      LanguageController languageController = Get.find<LanguageController>();
      localization = languageController.localization.value;
      inspect(localization);
    } else {
      LanguageController languageController =
          Get.put(LanguageController(), permanent: true);
      localization = languageController.localization.value;
    }
  }

  AvailableLanguage currentLanguage() {
    if (Get.isRegistered<LanguageController>()) {
      LanguageController languageController = Get.find<LanguageController>();
      return languageController.currentLanguage.value;
    } else {
      return AvailableLanguage.en;
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

  AvailableLanguage? languagefromString(String? locale) {
    if (locale == null) return null;
    return AvailableLanguage.values.firstWhere(
        (element) => element.languageCode == locale,
        orElse: () => AvailableLanguage.en);
  }

  AvailableLanguage? languagefromLocale(String? locale) {
    if (locale == null) return null;
    return AvailableLanguage.values.firstWhere(
        (element) => element.locale == locale,
        orElse: () => AvailableLanguage.en);
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void onHidden() {}
}

class LanguageController extends GetxController {
  Rx<Localization> parentLocalization = Localization().obs;
  Rx<LocalizationKey> localization = LocalizationKey().obs;
  GetLocalizationData getLocalizationData = GetLocalizationData.instance();
  Rx<AvailableLanguage> currentLanguage = AvailableLanguage.en.obs;
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
          currentLanguage.value = AvailableLanguage.en;
          break;
        case AvailableLanguage.id:
          localization.value = r.idID!;
          currentLanguage.value = AvailableLanguage.id;
          break;
      }
    });
  }

  AvailableLanguage? languagefromString(String? locale) {
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

extension AvailableLanguageContent on AvailableLanguage {
  String code() {
    switch (this) {
      case AvailableLanguage.en:
        return 'en_US';
      case AvailableLanguage.id:
        return 'id_ID';
    }
  }
}

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
