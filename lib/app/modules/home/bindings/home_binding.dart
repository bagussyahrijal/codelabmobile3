import 'package:codelab/app/modules/home/controllers/auth_controller.dart';
import 'package:codelab/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
