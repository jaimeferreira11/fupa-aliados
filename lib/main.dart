import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/reporte-totales/reporte_totales_binding.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/reporte-totales/reporte_totales_page.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/solicitar-credito/solicitar_credito_binding.dart';
import 'package:fupa_aliados/app/modules/pin_code/pin_code_binding.dart';
import 'package:fupa_aliados/app/modules/pin_code/pin_code_page.dart';
import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/config/dependencies/dependency_injection.dart';
import 'app/modules/microfranquicia/solicitar-credito/solicitar_credito_page.dart';
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
      title: 'Aliados FP',
      debugShowCheckedModeBanner: false,
      // idioma
      locale: Get.deviceLocale,
      theme: buildThemeData(),
      home: ReporteTotalesPage(),
      initialBinding: ReporteTotalesBinding(),
      getPages: AppPage.pages,
    );
  }
}
