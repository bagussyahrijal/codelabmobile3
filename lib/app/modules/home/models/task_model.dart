class TaskModel {
  String? id;
  String title;
  String description;
  bool completed;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  // Convert TaskModel to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  // Convert Firestore DocumentSnapshot to TaskModel
  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: id,
      title: map['title'],
      description: map['description'],
      completed: map['completed'] ?? false,
    );
  }
}
