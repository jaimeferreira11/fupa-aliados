import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/config/dependencies/dependency_injection.dart';
import 'app/modules/splash/splash_binding.dart';
import 'app/modules/splash/splash_page.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/theme.dart';

void initAppCenter() async {
  final ios = defaultTargetPlatform == TargetPlatform.iOS;
  var app_secret = ios
      ? "123cfac9-123b-123a-123f-123273416a48"
      : "2f4f4e86-bff5-47a0-8e3d-e5a3754edbbc";

  await AppCenter.start("{2f4f4e86-bff5-47a0-8e3d-e5a3754edbbc}",
      [AppCenterAnalytics.id, AppCenterCrashes.id]);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependecyInjection.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initAppCenter();
    initializeDateFormatting('es_EN');
    return GetMaterialApp(
      title: 'Aliados Fundación Paraguaya',
      debugShowCheckedModeBanner: false,
      // idioma
      locale: Get.deviceLocale,
      theme: buildThemeData(),
      home: SplashPage(),
      initialBinding: SplashBinding(),
      getPages: AppPage.pages,
    );
  }
}
