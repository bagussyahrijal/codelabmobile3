import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class TaskView extends StatelessWidget {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (_taskController.tasks.isEmpty) {
                return Center(child: Text('No tasks available'));
              }
              return ListView.builder(
                itemCount: _taskController.tasks.length,
                itemBuilder: (context, index) {
                  final task = _taskController.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Checkbox(
                      value: task.completed,
                      onChanged: (val) {
                        _taskController.updateTask(
                          TaskModel(
                            id: task.id,
                            title: task.title,
                            description: task.description,
                            completed: val!,
                          ),
                        );
                      },
                    ),
                    onLongPress: () {
                      _taskController.deleteTask(task.id!);
                    },
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: 'Task Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(hintText: 'Task Description'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _taskController.addTask(
                      _titleController.text,
                      _descriptionController.text,
                    );
                    _titleController.clear();
                    _descriptionController.clear();
                  },
                  child: Text('Add Task'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
