import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/data/models/usuario_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notifications_keys.dart';
import 'package:fupa_aliados/app/modules/home/home_controller.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();

  final homeController = Get.find<HomeController>();

  UsuarioModel user = Cache.instance.user;

  @override
  void onReady() {
    super.onReady();
    // _init();
  }

  RxString error = "".obs;
  RxBool ignore = false.obs;
  final controller = TextEditingController();
  showDialog(
      String label, String placeholder, String tipo, String oldValue) async {
    TextInputType type = TextInputType.phone;
    if (tipo == 'correo') type = TextInputType.emailAddress;

    controller.text = "";
    print(oldValue);
    if (oldValue != null && oldValue.length > 0) controller.text = oldValue;

    Get.defaultDialog(
        title: 'Editar información',
        content: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   color: Colors.white,
              //   margin: EdgeInsets.only(
              //       top: 0.0, bottom: 10, left: 5.0, right: 5.0),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       label,
              //       style: TextStyle(
              //         fontFamily: "Roboto",
              //         fontWeight: FontWeight.w300,
              //         color: Color(0xff00004c),
              //         fontSize: 18,
              //       ),
              //     ),
              //   ),
              // ),
              InputWidget(
                label: label,
                keyboardType: type,
                valor: controller.text,
                placeHolder: tipo == 'celular' ? '09xxxxxxxx' : null,
                maxLength: tipo == 'celular' ? 10 : null,
                onChanged: (text) {
                  controller.text = text;
                },
              ),
              // TextField(
              //   controller: controller,
              //   keyboardType: type,
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //       labelText: placeholder,
              //       hintMaxLines: 1,
              //       border: OutlineInputBorder(
              //           borderSide:
              //               BorderSide(color: Colors.green, width: 4.0))),
              // ),
              Obx(() => Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        error.value,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      error.value = "";
                      nav.back();
                    },
                    child: Icon(
                      FontAwesomeIcons.times,
                      color: Colors.white,
                    ),
                    color: Colors.red.shade700,
                  ),
                  Obx(() => ignore.value
                      ? MaterialButton(
                          onPressed: null,
                          child: SpinKitWave(
                            color: AppColors.primaryColor,
                            type: SpinKitWaveType.end,
                            size: 24.0,
                          ),
                        )
                      : MaterialButton(
                          onPressed: () async {
                            print(controller.text);
                            if (controller.text.isNotEmpty) {
                              error.value = "";

                              switch (tipo) {
                                case "correo":
                                  if (!controller.text.contains('@')) {
                                    error.value = 'Correo invalido';
                                  } else {
                                    user.email = controller.text;
                                  }

                                  break;

                                case "celular":
                                  if (controller.text.length < 10) {
                                    error.value = 'Numero de telefono invalido';
                                  } else {
                                    user.phonenumber = controller.text;
                                  }
                                  break;
                                default:
                                  break;
                              }
                              await actualizar(user);
                              //print('Usuario a actualizar' + user.toString());
                            } else {
                              error.value = "Complete el campo";
                            }
                          },
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                          ),
                          color: Colors.green.shade700,
                        )),
                ],
              )
            ],
          ),
        ),
        radius: 10.0);
  }

  actualizar(UsuarioModel user) async {
    ignore.value = true;
    final resp = await serverRepo.actualizarUsuario(user);
    ignore.value = false;
    resp.fold((l) => noti.mostrarInternalError(mensaje: "Intente mas tarde"),
        (r) {
      update();
      nav.back();
      noti.mostrarSnackBar(
          color: NotiKey.SUCCESS,
          mensaje: "",
          titulo: "Actualizado",
          position: SnackPosition.BOTTOM);
    });
  }
}
