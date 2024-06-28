import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LandingAuthController extends BaseController {
  Rx<String> appVersion = "".obs;
  Rx<String> buildNumber = "".obs;
  @override
  void onInit() {
    super.onInit();
    getAppVersion();
    trackEvent(LivewellAuthEvent.landingPage);
  }

  void fetchLocalization() {
    getLocalizationDatas();
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
    buildNumber.value = packageInfo.buildNumber;
  }
}
