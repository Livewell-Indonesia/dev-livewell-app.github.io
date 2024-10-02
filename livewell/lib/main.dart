import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/core/notification/firebase_notification.dart';
import 'package:livewell/core/remote_config/remote_config_service.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/splash/presentation/splash_screen.dart';
import 'package:livewell/firebase_options.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'feature/food/presentation/pages/food_screen.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMesage(RemoteMessage mesage) async {
  // Log.info('Handling a background message ${mesage.messageId}');
  // final payload = mesage.data['data'];
  // final decodedPayload = jsonDecode(payload) as Map<String, dynamic>;
  // if (decodedPayload['type'] != null) {
  //   mapPayloadToRoute(decodedPayload['type']);
  // }
  await LivewellNotification.handleNotification(mesage);
}

void mapPayloadToRoute(String payload) {
  //add delay 2 sec
  Future.delayed(const Duration(seconds: 1), () {
    AppNavigator.push(routeName: AppPages.addMeal, arguments: {'type': FeatureTypeNotification.values.firstWhere((element) => element.value == payload).mealTime.name, 'date': DateTime.now()});
  });
}

enum FeatureTypeNotification { mealReminderBreakfast, mealReminderSnack, mealReminderLunch, mealReminderDinner, sleepPage, exercisePage, taskList }

extension MealReminderExt on FeatureTypeNotification {
  String get value {
    switch (this) {
      case FeatureTypeNotification.mealReminderBreakfast:
        return 'MEAL_REMINDER_BREAKFAST';
      case FeatureTypeNotification.mealReminderSnack:
        return 'MEAL_REMINDER_SNACK';
      case FeatureTypeNotification.mealReminderLunch:
        return 'MEAL_REMINDER_LUNCH';
      case FeatureTypeNotification.mealReminderDinner:
        return 'MEAL_REMINDER_DINNER';
      case FeatureTypeNotification.sleepPage:
        return 'SLEEP_PAGE';
      case FeatureTypeNotification.exercisePage:
        return 'EXERCISE_PAGE';
      case FeatureTypeNotification.taskList:
        return 'TASK_LIST';
    }
  }

  MealTime get mealTime {
    switch (this) {
      case FeatureTypeNotification.mealReminderBreakfast:
        return MealTime.breakfast;
      case FeatureTypeNotification.mealReminderSnack:
        return MealTime.snack;
      case FeatureTypeNotification.mealReminderLunch:
        return MealTime.lunch;
      case FeatureTypeNotification.mealReminderDinner:
        return MealTime.dinner;
      default:
        return MealTime.breakfast;
    }
  }

  VoidCallback execute() {
    switch (this) {
      case FeatureTypeNotification.mealReminderBreakfast:
      case FeatureTypeNotification.mealReminderSnack:
      case FeatureTypeNotification.mealReminderLunch:
      case FeatureTypeNotification.mealReminderDinner:
        return () {
          AppNavigator.push(routeName: AppPages.addMeal, arguments: {'type': FeatureTypeNotification.values.firstWhere((element) => element.value == value).mealTime.name, 'date': DateTime.now()});
        };
      case FeatureTypeNotification.sleepPage:
        return () {
          AppNavigator.push(routeName: AppPages.sleepScreen);
        };
      case FeatureTypeNotification.exercisePage:
        return () {
          AppNavigator.push(routeName: AppPages.exerciseScreen);
        };
      case FeatureTypeNotification.taskList:
        return () {
          if (Get.isRegistered<HomeController>()) {
            Get.find<HomeController>()
                .scrollController
                .animateTo(Get.find<HomeController>().scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
          }
        };
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAc-eYwFgTwe2w7jZuae_jmjrn0oBUowzE',
        appId: '1:649229634613:web:4214220332235e2665357c',
        messagingSenderId: '649229634613',
        projectId: 'livewell-apps',
        authDomain: 'livewell-apps.firebaseapp.com',
        storageBucket: 'livewell-apps.appspot.com',
        measurementId: 'G-X1XZSLJDPR',
      ),
    );
    runApp(MyApp());
  } else {
    var app = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  initializeDateFormatting('id_ID');
  await LivewellNotification().init();
  //FirebaseMessaging.onBackgroundMessage(handleBackgroundMesage);
  var mixPanel = await Mixpanel.init("b95e1ff0a63a8b2d63e10d2b7b0e8757", trackAutomaticEvents: false);
  Get.putAsync(() async => LivewellTrackerService(mixPanel));

  if (GetPlatform.isWeb) {
    usePathUrlStrategy();
  }

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // runZonedGuarded(() async {
  //   Sentry.init(
  //     (p0) {
  //       p0.dsn = 'https://344e610591e04e998dda24b51c38c4e0@o4505522504400896.ingest.sentry.io/4505545112616960';
  //     },
  //     appRunner: () async {},
  //   );
  // }, (error, stackTrace) async {
  //   await Sentry.captureException(error, stackTrace: stackTrace);
  // });

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ScreenUtil.ensureScreenSize();
  configLoading();

  runApp(MyApp());
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

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: false,
      fontSizeResolver: (fontSize, instance) => FontSizeResolvers.radius(fontSize, instance),
      builder: (context, child) {
        return GetMaterialApp(
          builder: EasyLoading.init(
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: widget!,
              );
            },
          ),
          title: 'LiveWell',
          debugShowCheckedModeBanner: false,
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          initialRoute: AppNavigator.initialRoute,
          getPages: AppNavigator.pages,
          theme: ThemeData(
            primarySwatch: mycolor,
            textTheme: GoogleFonts.archivoTextTheme(
              Theme.of(context).textTheme,
            ),
            brightness: Brightness.light,
          ),
          home: const SplashScreen(),
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
