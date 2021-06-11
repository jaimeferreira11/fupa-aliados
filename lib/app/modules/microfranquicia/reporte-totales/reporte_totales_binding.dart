import 'package:get/get.dart';

import 'reporte_totales_controller.dart';

class ReporteTotalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReporteTotalesController());
  }
}
