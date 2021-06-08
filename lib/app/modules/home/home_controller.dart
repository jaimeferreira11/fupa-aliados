import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/globlas_widgets/cambiar_password_widget.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notifications_keys.dart';
import 'package:fupa_aliados/app/modules/home/home_page.dart';
import 'package:fupa_aliados/app/modules/home/local_widgets/about_app_view.dart';
import 'package:fupa_aliados/app/modules/profile/profile_page.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

import 'local_widgets/drawer_view.dart';

class HomeController extends GetxController {
  final serverRepo = Get.find<ServerRepository>();
  final authRepo = Get.find<AuthRepository>();
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();

  int selectedDrawerIndex = 0;
  String title = "Inicio";
  Widget selectedView = new HomeView();
  final drawerItems = [
    new DrawerItem("Inicio", FontAwesomeIcons.home),
    new DrawerItem("Perfil", FontAwesomeIcons.userAlt),
    new DrawerItem("Cambiar contraseña", FontAwesomeIcons.userLock),
    new DrawerItem("Sobre esta app", FontAwesomeIcons.copyright),
    new DrawerItem("Cerrar sesión", FontAwesomeIcons.signOutAlt)
  ];

  @override
  void onReady() {
    super.onReady();
    _init();
  }

  _init() async {}

  onSelectItem(int index) {
    nav.back();

// limoiar pantalla password
    limpiarPantallaPass();
    switch (index) {
      case 0:
        title = "Inicio";
        selectedDrawerIndex = index;
        selectedView = new HomeView();
        update();
        break;
      case 1:
        title = "Perfil";
        selectedDrawerIndex = index;
        selectedView = new ProfilePage();
        update();
        break;
      case 2:
        title = "Cambiar contraseña";
        selectedDrawerIndex = index;
        selectedView = new CambiarPasswordWidget();
        update();
        break;
      case 3:
        title = "Sobre esta app";
        selectedDrawerIndex = index;
        selectedView = new AboutAppView();
        update();
        break;
      case 4:
        launchDialogCerrarSesion();
        break;
      default:
        return new Text("");
    }
  }

// Cerrar sesion
  Future<void> launchDialogCerrarSesion() async {
    Get.dialog(
        AlertDialog(
          content: Text("Cerrando sesión...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300,
                  fontSize: 18.0,
                  color: Colors.black)),
        ),
        barrierDismissible: false);
    await cerrarSesion();
  }

  Future<void> cerrarSesion() async {
    await serverRepo.logout();
    print('Borrando el storage....');
    await authRepo.deleteAuthToken();
    await authRepo.deleteUsuario();

    Future.delayed(Duration(milliseconds: 500), () {
      nav.back();
      nav.goToAndClean(AppRoutes.LOGIN);
    });
  }

// cambiar pass
  bool workInProgress = false;

  String oldPassword;
  String newPassword;
  String repeatNewPassword;
  Map<String, TextEditingController> mapControllers = {
    "oldPassword": TextEditingController(),
    "newPassword": TextEditingController(),
    "repeatNewPassword": TextEditingController(),
  };
  Map<String, FocusNode> mapFocusNodes = {
    "oldPassword": FocusNode(),
    "newPassword": FocusNode(),
    "repeatNewPassword": FocusNode()
  };
  bool passwordVisible1 = false,
      passwordVisible2 = false,
      passwordVisible3 = false;
  RxBool ignore = false.obs;
  RxString errorPass = "".obs;

  limpiarPantallaPass() {
    passwordVisible1 = false;
    passwordVisible2 = false;
    passwordVisible3 = false;
    ignore.value = false;
    errorPass.value = "";
    oldPassword = "";
    newPassword = "";
    repeatNewPassword = "";
    mapControllers["oldPassword"].clear();
    mapControllers["newPassword"].clear();
    mapControllers["repeatNewPassword"].clear();
    update(['changePass']);
  }

  cambiarPass() async {
    if (newPassword == null ||
        repeatNewPassword == null ||
        oldPassword == null) {
      errorPass.value = "Completa los campos";
      return;
    }

    if (newPassword != repeatNewPassword) {
      errorPass.value = "Las nuevas contraseñas no coinciden";
      return;
    } else if (newPassword.length < 7 || oldPassword.length < 7) {
      errorPass.value = "Las contrasen1as deben tener al menos 7 caracteres";
      return;
    } else {
      errorPass.value = "";
    }
    ignore.value = true;

    final resp = await serverRepo.cambiarPassword(oldPassword, newPassword);

    ignore.value = false;
    resp.fold((l) {
      print('ERROR');
      if (l is CacheFailure) {
        print('CACHE ERROR');
        errorPass.value = l.mensaje;
      } else {
        print('OTHER ERROR');
        noti.mostrarInternalError(
            mensaje: l.mensaje, position: SnackPosition.BOTTOM);
      }
    }, (r) async {
      errorPass.value = "";
      limpiarPantallaPass();
      noti.mostrarSnackBar(
          color: NotiKey.SUCCESS,
          mensaje: "Contrasen1a actualizada correctamente",
          titulo: "Actualizado");
    });
  }
}
