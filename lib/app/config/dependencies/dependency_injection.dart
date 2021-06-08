import 'package:fupa_aliados/app/data/providers/remote/server_api.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/helpers/logger/logger_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get.dart';

import '../dio_config.dart';

class DependecyInjection {
  static Future<void> init() async {
    // ---------  Dio
    Get.lazyPut<DioService>(
      () => DioService(),
      fenix: true,
    );

    // --------- Modulos

    //  --------- --------- profile
    // ProfileDependencies.inject();

    // repositorios
    Get.lazyPut<ServerRepository>(() => ServerRepository(), fenix: true);
    Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);

    // providers
    Get.lazyPut<ServerAPI>(() => ServerAPI(), fenix: true);

    //  Util
    //  --------- Navigation

    Get.put<NavigatorController>(NavigatorController());

    //  --------- Notifications
    Get.put<NotificationService>(NotificationService());

    //  --------- Logger
    Get.put<LoggerService>(LoggerService());
  }
}
