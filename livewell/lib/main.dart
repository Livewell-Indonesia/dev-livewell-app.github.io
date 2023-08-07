import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/splash/presentation/splash_screen.dart';
import 'package:livewell/firebase_options.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _configureLocalTimeZone();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };
  runZonedGuarded(() async {
    Sentry.init(
      (p0) {
        p0.dsn =
            'https://344e610591e04e998dda24b51c38c4e0@o4505522504400896.ingest.sentry.io/4505545112616960';
      },
      appRunner: () async {
        cameras = await availableCameras();
        SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        await ScreenUtil.ensureScreenSize();
        configLoading();

        runApp(const MyApp());
      },
    );
  }, (error, stackTrace) async {
    await Sentry.captureException(error, stackTrace: stackTrace);
  });
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
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
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          initialRoute: AppNavigator.initialRoute,
          getPages: AppNavigator.pages,
          theme: ThemeData(
              fontFamily: GoogleFonts.archivo().fontFamily,
              primarySwatch: mycolor,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              brightness: Brightness.light),
          home: YourPage(),
        );
      },
    );
  }
}

class ImageWithOverlay extends StatelessWidget {
  final String imageUrl;
  final String overlayText;
  final double aspectRatio;

  ImageWithOverlay({
    required this.imageUrl,
    required this.overlayText,
    required this.aspectRatio,
  });

  Future<Uint8List> _captureWidgetToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      print(e);
      return Uint8List(0);
    }
  }

  // ... existing code ...

  @override
  Widget build(BuildContext context) {
    final GlobalKey key = GlobalKey();
    // ... existing code ...

    return RepaintBoundary(
      key: key,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                alignment: Alignment.center,
                child: Text(
                  overlayText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> shareToInstagramStory(BuildContext context, GlobalKey key) async {
  try {
    Uint8List imageBytes = await ImageWithOverlay(
      aspectRatio: 16 / 9,
      overlayText: "andi",
      imageUrl:
          "https://pusakadunia.com/wp-content/uploads/2016/12/sabuk-beladiri-warna-abu-abu.jpg",
    )._captureWidgetToImage(key);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/andi_asrafil.png');
    await file.writeAsBytes(imageBytes);
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'andi asrafil',
      subject: 'Share to Instagram Story',
    );
  } catch (e) {
    print('Error sharing to Instagram: $e');
  }
}

class YourPage extends StatelessWidget {
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Overlay Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RepaintBoundary(
            key: _key1,
            child: ImageWithOverlay(
              imageUrl:
                  'https://pusakadunia.com/wp-content/uploads/2016/12/sabuk-beladiri-warna-abu-abu.jpg',
              overlayText: 'andi asrafil',
              aspectRatio: 1.0,
            ),
          ),
          RepaintBoundary(
            key: _key2,
            child: ImageWithOverlay(
              imageUrl:
                  'https://pusakadunia.com/wp-content/uploads/2016/12/sabuk-beladiri-warna-abu-abu.jpg',
              overlayText: 'andi asrafil',
              aspectRatio: 16.0 / 9.0,
            ),
          ),
          ElevatedButton(
            onPressed: () => shareToInstagramStory(context, _key1),
            child: Text('Share 1:1 to Instagram Story'),
          ),
          ElevatedButton(
            onPressed: () => shareToInstagramStory(context, _key2),
            child: Text('Share 16:9 to Instagram Story'),
          ),
        ],
      ),
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
