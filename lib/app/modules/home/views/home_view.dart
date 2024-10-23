import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomeView extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),   // Tombol Logout
            onPressed: () {
              _authController.logout();  // Fungsi logout
            },
          )
        ],
      ),
      body: Center(
        child: Text('Welcome to Home!'),
      ),
    );
  }
}
