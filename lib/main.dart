import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/config/dependencies/dependency_injection.dart';
import 'app/modules/splash/splash_binding.dart';
import 'app/modules/splash/splash_page.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/theme.dart';

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
