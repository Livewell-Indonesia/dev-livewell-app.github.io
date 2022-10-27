import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/localization/Languages.dart';
import 'package:livewell/feature/splash/presentation/splash_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ScreenUtil.ensureScreenSize();
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = const Color(0xFF8F01DF)
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
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
          builder: EasyLoading.init(builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          }),
          title: 'LiveWell',
          debugShowCheckedModeBanner: false,
          translations: Languages(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          initialRoute: AppNavigator.initialRoute,
          getPages: AppNavigator.pages,
          theme: ThemeData(
              fontFamily: GoogleFonts.archivo().fontFamily,
              primarySwatch: mycolor,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              brightness: Brightness.light),
          home: SplashScreen(),
        );
      },
    );
  }
}

MaterialColor mycolor = const MaterialColor(
  0xFF8F01DF,
  <int, Color>{
    50: Color(0xFF8F01DF),
    100: Color(0xFF8F01DF),
    200: Color(0xFF8F01DF),
    300: Color(0xFF8F01DF),
    400: Color(0xFF8F01DF),
    500: Color(0xFF8F01DF),
    600: Color(0xFF8F01DF),
    700: Color(0xFF8F01DF),
    800: Color(0xFF8F01DF),
    900: Color(0xFF8F01DF),
  },
);
