import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/page/questionnaire_screen.dart';
import 'package:livewell/theme/design_system.dart';

import 'feature/auth/presentation/page/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'DM Sans',
          primaryColor: AppColors.primary100,
          brightness: Brightness.light),
      home: QuestionnaireScreen(),
    );
  }
}
