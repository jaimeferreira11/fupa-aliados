import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ReporteTotalesController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();

  @override
  void onReady() async {
    super.onReady();
    await _init();
    generateListofMonths();
  }

  _init() async {}

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
}
