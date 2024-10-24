part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  _Paths._();
  static const LOGIN = '/login';
  static const REGISTER = '/register';
 static const HOME = '/home';
  static const TASKS = '/tasks';  // Route for TaskView (HomeScreen)
  static const CREATE_TASK = '/create-task';  // Route for CreateTaskScreen


}
