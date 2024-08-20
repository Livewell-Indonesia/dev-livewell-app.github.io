import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/localization/localization_model_v2.dart';
import 'package:livewell/feature/splash/domain/usecase/get_localization_data.dart';
import 'package:livewell/feature/wellness/presentation/controller/wellness_controller.dart';

class BaseController extends FullLifeCycleController with FullLifeCycleMixin {
  LocalizationKeyV2 localization = LocalizationKeyV2();
  LivewellTrackerService livewellTracker = Get.find();
  late WellnessCalculationModel wellnessCalculationModel;
  @override
  void onInit() {
    getLocalizationDatas();
    wellnessCalculationModel = WellnessCalculationModel.generate(localization.wellnessCalculation ?? {});
    super.onInit();
  }

  void trackEvent(String event, {Map<String, dynamic>? properties}) async {
    if (properties != null) {
      properties['email'] = await SharedPref.getEmail();
      properties['gender'] = await SharedPref.getGender();
      properties['birth_date'] = await SharedPref.getBirthDate();
      properties['name'] = await SharedPref.getName();
      livewellTracker.trackEvent(event, properties: properties);
    } else {
      livewellTracker.trackEvent(event, properties: {
        'email': await SharedPref.getEmail(),
        'gender': await SharedPref.getGender(),
        'birth_date': await SharedPref.getBirthDate(),
        'name': await SharedPref.getName(),
      });
    }
  }

  void getLocalizationDatas() async {
    if (Get.isRegistered<LanguageController>()) {
      LanguageController languageController = Get.find<LanguageController>();
      localization = languageController.localization.value;
    } else {
      LanguageController languageController = Get.put(LanguageController(), permanent: true);
      localization = languageController.localization.value;
    }
  }

  String getCurrentLocale() {
    if (Get.isRegistered<LanguageController>()) {
      LanguageController languageController = Get.find<LanguageController>();
      return languageController.currentLanguage.value.locale;
    } else {
      return AvailableLanguage.id.locale;
    }
  }

  AvailableLanguage currentLanguage() {
    if (Get.isRegistered<LanguageController>()) {
      LanguageController languageController = Get.find<LanguageController>();
      return languageController.currentLanguage.value;
    } else {
      return AvailableLanguage.id;
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
    return AvailableLanguage.values.firstWhere((element) => element.languageCode == locale, orElse: () => AvailableLanguage.en);
  }

  AvailableLanguage? languagefromLocale(String? locale) {
    if (locale == null) return null;
    return AvailableLanguage.values.firstWhere((element) => element.locale == locale, orElse: () => AvailableLanguage.en);
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
  Rx<LocalizationModelV2> parentLocalization = LocalizationModelV2().obs;
  Rx<LocalizationKeyV2> localization = LocalizationKeyV2().obs;
  GetLocalizationDataV2 getLocalizationData = GetLocalizationDataV2.instance();
  Rx<AvailableLanguage> currentLanguage = AvailableLanguage.id.obs;
  @override
  void onInit() {
    //getLocalizationDatas();
    Intl.defaultLocale = 'id_ID';
    super.onInit();
  }

  void getLocalizationDatas() async {
    final result = await getLocalizationData.call(NoParams());
    result.fold((l) {}, (r) {
      parentLocalization.value = r;
    });
    // final result = await getLocalizationDataV2.call(NoParams());
    // result.fold((l) {}, (r) {
    //   lovalizationV2.value = r;
    // });
  }

  Future<void> changeLocalization(AvailableLanguage lang) async {
    final result = await getLocalizationData.call(NoParams());
    result.fold((l) {}, (r) {
      parentLocalization.value = r;
      switch (lang) {
        case AvailableLanguage.en:
          localization.value = r.enUs!;
          currentLanguage.value = AvailableLanguage.en;
          Intl.defaultLocale = 'en_US';
          break;
        case AvailableLanguage.id:
          localization.value = r.idId!;
          currentLanguage.value = AvailableLanguage.id;
          Intl.defaultLocale = 'id_ID';
          break;
      }
    });
  }

  AvailableLanguage? languagefromString(String? locale) {
    if (locale == null) return null;
    return AvailableLanguage.values.firstWhere((element) => element.languageCode == locale, orElse: () => AvailableLanguage.en);
  }

  AvailableLanguage? LanguagefromLocale(String? locale) {
    if (locale == null) return null;
    return AvailableLanguage.values.firstWhere((element) => element.locale == locale, orElse: () => AvailableLanguage.en);
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
