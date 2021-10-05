import 'package:fupa_aliados/app/data/models/solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_seguro_model.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notifications_keys.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReporteSegurosController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();

  RxBool existeDatos = false.obs;
  RxBool buscando = false.obs;
  String mes;
  String anio;
  List<SolicitudSeguroModel> list = [];
  double total = 0;
  int cantidad = 0;
  var numberFormat = new NumberFormat("###,###", "es_ES");

  @override
  void onReady() async {
    super.onReady();
    _init();
  }

  _init() {
    anio = DateFormat('y').format(DateTime.now());
    mes = DateFormat('MMMM', 'es_US').format(DateTime.now());
    obtenerReporte();
  }

  List<String> generateListofMonths() {
    DateTime now = DateTime.now();
    List<String> list = [];
    for (int i = 0; i < 12; i++) {
      list.add(
          DateFormat('MMMM', 'es_US').format(DateTime(now.year, i, now.day)));
    }
    return list;
  }

  List<String> generateListofyears() {
    List<String> list = [];
    final year = DateFormat('y').format(DateTime.now());
    for (int i = 2019; i <= int.parse(year); i++) {
      list.add('$i');
    }

    return list;
  }

  Future<Null> refresh() async {
    await this.obtenerReporte();
    return null;
  }

  Future<void> obtenerReporte() async {
    buscando.value = true;
    list = [];
    cantidad = 0;
    total = 0;
    existeDatos.value = false;
    var auxDate =
        new DateFormat("yyyy-MMMM-dd", 'es_US').parse("$anio-$mes-01");

    var mesNumber = DateFormat('M', 'es_US').format(auxDate);

    final resp = await serverRepo.obtenerReporteSeguros(
        int.parse(mesNumber), int.parse(anio));

    resp.fold((l) {
      buscando.value = false;
      noti.mostrarInternalError(mensaje: "Intente mas tarde");
    }, (r) {
      list = r;
      cantidad = list.length;
      list.forEach((e) => total = total + e.monto);
      update(['detalles', 'totales']);
      buscando.value = false;
      if (r.isEmpty) {
        return noti.mostrarSnackBar(
            color: NotiKey.INFO,
            mensaje: "Intentá con otros parametros",
            titulo: "No existen registros");
      } else {
        existeDatos.value = true;
      }
    });
  }
}
