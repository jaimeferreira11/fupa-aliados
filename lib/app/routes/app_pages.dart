import 'package:fupa_aliados/app/modules/home/home_binding.dart';
import 'package:fupa_aliados/app/modules/home/home_page.dart';
import 'package:fupa_aliados/app/modules/login/login_binding.dart';
import 'package:fupa_aliados/app/modules/login/login_page.dart';
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
  ];
}
