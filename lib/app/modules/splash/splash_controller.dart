import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/globlas_widgets/new_version_view.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class SplashController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();

  @override
  void onReady() {
    super.onReady();
    _init();
  }

  _init() async {
    final resp = await serverRepo.getVersion();

    resp.fold((l) => verificarSesion(), (r) async {
      final PackageInfo info = await PackageInfo.fromPlatform();

      final localVersion = int.parse(info.buildNumber);
      print('version en el server: $r');
      print('version local: $localVersion');
      if (r > localVersion) {
        Get.offAll(NewVersionView());
        return;
      } else {
        Cache.instance.version = info.version;
        verificarSesion();
      }
    });
  }

  Future verificarSesion() async {
    final respuesta = await authRepo.getAuthToken();

    respuesta.fold(
      (l) => Future.delayed(
        Duration(seconds: 2),
        () {
          nav.goToOff(AppRoutes.LOGIN);
        },
      ),
      (r) => Future.delayed(
        Duration(seconds: 2),
        () async {
          final resSession = await serverRepo.verfificarSession();
          resSession.fold((l) {
            print('No tiene session');
            authRepo.deleteAuthToken();
            authRepo.deleteUsuario();
            nav.goToOff(AppRoutes.LOGIN);
          }, (r) async {
            if (r.tipobeneficiario < 100) {
              nav.goToOff(AppRoutes.LOGIN);
              return;
            }
            print("Tiene session activa");

            await authRepo.setUsuario(r);

            nav.goToAndClean(AppRoutes.HOME);
          });
        },
      ),
    );
  }
}
