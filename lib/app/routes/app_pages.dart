import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/nueva_solicitud_binding.dart';
import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/nueva_solicitud_page.dart';
import 'package:fupa_aliados/app/modules/agente/reporte-totales/reporte_agente_binding.dart';
import 'package:fupa_aliados/app/modules/agente/reporte-totales/reporte_agente_page.dart';
import 'package:fupa_aliados/app/modules/agente/solicitudes-realizadas/solicitudes_agente_binding.dart';
import 'package:fupa_aliados/app/modules/agente/solicitudes-realizadas/solicitudes_agente_page.dart';
import 'package:fupa_aliados/app/modules/home/home_binding.dart';
import 'package:fupa_aliados/app/modules/home/home_page.dart';
import 'package:fupa_aliados/app/modules/login/login_binding.dart';
import 'package:fupa_aliados/app/modules/login/login_page.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/reporte-totales/reporte_totales_binding.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/reporte-totales/reporte_totales_page.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/solicitar-credito/solicitar_credito_binding.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/solicitar-credito/solicitar_credito_page.dart';
import 'package:fupa_aliados/app/modules/pin_code/pin_code_binding.dart';
import 'package:fupa_aliados/app/modules/pin_code/pin_code_page.dart';
import 'package:fupa_aliados/app/modules/register/register_binding.dart';
import 'package:fupa_aliados/app/modules/register/register_page.dart';
import 'package:fupa_aliados/app/modules/splash/splash_binding.dart';
import 'package:fupa_aliados/app/modules/splash/splash_page.dart';
import 'package:get/route_manager.dart';

import 'app_routes.dart';

class AppPage {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.SPLAH,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.REGISTER,
        page: () => RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: AppRoutes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: AppRoutes.SOLICITAR_CREDITO,
        page: () => SolicitarCreditoPage(),
        binding: SolicitarCreditoBinding()),
    GetPage(
        name: AppRoutes.PIN_CODE,
        page: () => PinCodePage(),
        binding: PinCodeBinding()),
    GetPage(
        name: AppRoutes.REPORTE_TOTALES,
        page: () => ReporteTotalesPage(),
        binding: ReporteTotalesBinding()),
    GetPage(
        name: AppRoutes.NUEVA_SOLICITUD,
        page: () => NuevaSolcitudPage(),
        binding: NuevaSolicitudBinding()),
    GetPage(
        name: AppRoutes.REPORTE_AGENTE,
        page: () => ReporteAgentePage(),
        binding: ReporteAgenteBinding()),
    GetPage(
        name: AppRoutes.SOLICITUDES_AGENTE,
        page: () => SolicitudesAgentePage(),
        binding: SolicitudesAgenteBinding()),
  ];
}
