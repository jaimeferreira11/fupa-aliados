import 'package:fupa_aliados/app/modules/home/home_controller.dart';
import 'package:fupa_aliados/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());

    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
