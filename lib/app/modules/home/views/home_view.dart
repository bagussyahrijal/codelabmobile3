import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codelab/app/modules/home/utils/app_color.dart';
import 'package:codelab/app/modules/home/views/create_task_screen.dart';
import 'package:codelab/app/modules/home/widgets/widget_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final AppColor appColor = AppColor();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.colorPrimary,
      body: Stack(
        children: <Widget>[
          WidgetBackground(),
          StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('tasks').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  final data = doc.data()! as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      title: Text(data['name']),
                      subtitle: Text(data['description']),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String value) async {
                          if (value == 'edit') {
                            Get.to(CreateTaskScreen(
                              isEdit: true,
                              documentId: doc.id,
                              name: data['name'],
                              description: data['description'],
                              date: data['date'],
                            ));
                          } else if (value == 'delete') {
                            await firestore.collection('tasks').doc(doc.id).delete();
                            Get.snackbar('Success', 'Task deleted successfully',
                                backgroundColor: Colors.green);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ];
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CreateTaskScreen(isEdit: false));
        },
        child: Icon(Icons.add),
        backgroundColor: appColor.colorTertiary,
      ),
    );
  }
}
