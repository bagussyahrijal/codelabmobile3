import 'package:codelab/app/modules/home/bindings/home_binding.dart';
import 'package:codelab/app/modules/home/views/create_task_screen.dart';
import 'package:codelab/app/modules/home/views/login_page.dart';
import 'package:codelab/app/modules/home/views/register_page.dart';
import 'package:codelab/app/modules/home/views/task_view.dart';
import 'package:get/get.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.REGISTER;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TASK,
      page: () => CreateTaskScreen(isEdit: false), // Page for creating task
    ),

  ];
}
