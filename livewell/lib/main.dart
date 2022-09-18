import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:livewell/core/localization/Languages.dart';
import 'package:livewell/feature/splash/presentation/splash_screen.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          builder: (context, widget) {
            ScreenUtil.init(context);
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!);
          },
          title: 'LiveWell',
          debugShowCheckedModeBanner: false,
          translations: Languages(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          theme: ThemeData(
              fontFamily: 'DM Sans',
              primaryColor: AppColors.primary100,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              brightness: Brightness.light),
          home: SplashScreen(),
        );
      },
    );
  }
}
