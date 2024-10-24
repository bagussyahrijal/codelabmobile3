import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:codelab/app/modules/home/models/task_model.dart';
import 'auth_controller.dart';

class TaskController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController _authController = Get.find<AuthController>();

  RxList<TaskModel> tasks = RxList<TaskModel>([]);

  @override
  void onInit() {
    super.onInit();
    fetchTasks();  // Fetch tasks when controller is initialized
  }

  // Fetch tasks for the current user
  void fetchTasks() {
    if (_authController.userId != null) {
      _firestore
          .collection('users')
          .doc(_authController.userId)
          .collection('tasks')
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        tasks.value = snapshot.docs
            .map((doc) => TaskModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
            .toList();
      });
    }
  }

  // Create new task
  Future<void> addTask(String title, String description) async {
    if (_authController.userId != null) {
      await _firestore
          .collection('users')
          .doc(_authController.userId)
          .collection('tasks')
          .add(TaskModel(title: title, description: description).toMap());
    }
  }

  // Update existing task
  Future<void> updateTask(TaskModel task) async {
    if (_authController.userId != null && task.id != null) {
      await _firestore
          .collection('users')
          .doc(_authController.userId)
          .collection('tasks')
          .doc(task.id)
          .update(task.toMap());
    }
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    if (_authController.userId != null) {
      await _firestore
          .collection('users')
          .doc(_authController.userId)
          .collection('tasks')
          .doc(taskId)
          .delete();
    }
  }
}
