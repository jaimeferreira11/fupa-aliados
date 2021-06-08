import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/globlas_widgets/yes_no_dialog.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notifications_keys.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginController extends GetxController {
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();
  final serverRepo = Get.find<ServerRepository>();
  final authRepo = Get.find<AuthRepository>();

  RxBool _ignore = false.obs;
  RxBool _ignore2 = false.obs;
  RxBool _obscure = true.obs;

  RxBool get ignore => _ignore;
  RxBool get ignore2 => _ignore2;
  bool get mostrarPassword => _obscure.value;

  void cambiarMostrarPassword() => _obscure.value = !_obscure.value;

  final FormGroup loginForm = FormGroup({
    'user': FormControl(
      value: '',
      validators: [
        Validators.required,
      ],
    ),
    'password': FormControl(
      value: '',
      validators: [
        Validators.required,
      ],
    ),
  });

  final FormGroup recuperarPasswordForm = FormGroup({
    'username': FormControl(
      value: '',
      validators: [Validators.required],
    ),
  });

  String get username => this.loginForm.control('user').value;
  String get password => this.loginForm.control('password').value;

  String correo;

  void login() async {
    _ignore.value = true;

    try {
      final result = await serverRepo.login(username, password);

      result.fold(
        (l) {
          _ignore.value = false;
          noti.mostrarSnackBar(
            color: NotiKey.ERROR,
            titulo: 'Crendenciales inválidas',
            mensaje: "Usuario o contraseña incorrectos",
          );
          // _obscure.value = true;
          //  loginForm.control('user').value = '';
          loginForm.control('password').value = '';
          loginForm
              .control('password')
              .setErrors({'Usuario o contraseña incorrectos': true});
          loginForm.focus('password');
        },
        (r) async {
          await authRepo.setAuthToken(r);
          await obtenerUserInfo(r.accessToken);
        },
      );
    } catch (e) {
      _ignore.value = false;
      print(e);
    }
  }

  Future<void> obtenerUserInfo(String token) async {
    final resp = await serverRepo.obtenerUserInfo(token);

    resp.fold((l) {
      _ignore.value = false;
      noti.mostrarSnackBar(
        color: NotiKey.ERROR,
        titulo: 'Ocurrio un error',
        mensaje: "Intente en unos minutos",
      );
    }, (r) async {
      _ignore.value = false;
      // verificar el tipo de beneficiario
      print(r);
      if (r.tipobeneficiario < 100) {
        loginForm.control('user').setErrors({'Usuario no autorizado': true});
        await authRepo.deleteAuthToken();
      } else {
        await authRepo.setUsuario(r);

        nav.goToAndClean(AppRoutes.HOME);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    _init();
  }

  _init() async {}

  recoveryPassword() async {
    _ignore.value = true;

    /* final resp = await serverRepo.recuperarClave(correo);
    _ignore.value = false;

    resp.fold((l) => noti.mostrarInternalError(mensaje: "Intente mas tarde"),
        (r) => DialogoSiNo().abrirDialogo("Contraseña restablecida", r)); */
  }
}
