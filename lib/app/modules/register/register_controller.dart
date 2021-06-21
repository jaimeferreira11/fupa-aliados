import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/globlas_widgets/yes_no_dialog.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterController extends GetxController {
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();
  final serverRepo = Get.find<ServerRepository>();

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
      validators: [Validators.required],
    ),
    'correo': FormControl(
      value: '',
      validators: [Validators.email],
    ),
    'password': FormControl(
      value: '',
      validators: [
        Validators.required,
      ],
    ),
    'contacto': FormControl(
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
  String get correo => this.loginForm.control('correo').value;
  String get contacto => this.loginForm.control('contacto').value;

  //String correo;

  void login() async {
    String mensaje =
        "Un usuario quiere registrarse a la aplicación <b>Aliados FP</b>: <br><br>";
    mensaje += "<b>Nombre:</b> " + username;
    if (correo != null) mensaje += "<br><b>Correo:</b> " + correo;
    mensaje += "<br><b>Contacto:</b> " + contacto;

    _ignore.value = true;
    await serverRepo.sendMail("Aliados FP - Intento de registro", mensaje);
    _ignore.value = false;
    await DialogoSiNo().abrirDialogoSucccess(
        "Te notificaremos cuando puedas ingresar a la app");
    nav.goToAndClean(AppRoutes.LOGIN);
    /* 
    
    
    loginSistema(
      ParamsLogin(
        username: username,
        password: password,
      ),
    );
    _ignore.value = false;

    result.fold(
      (l) {
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
        final SetAuthToken setAuthToken = Get.find<SetAuthToken>();
        await setAuthToken(
          SetTokenParams(
              username: r.usuario.username,
              token: r.accessToken,
              authority: r.usuario.authority),
        );
        final SetUsuario setUsuario = Get.find<SetUsuario>();
        await setUsuario(r.usuario);

        // revisar si ya leyo los terminos
        if (r.usuario.terms) {
          nav.goToAndClean(AppRoutes.HOME);
        } else {
          nav.goToAndClean(AppRoutes.TERMINOS);
        }
      },
    ); */
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
