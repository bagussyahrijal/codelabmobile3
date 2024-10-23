import 'package:codelab/app/modules/home/controllers/auth_controller.dart';
import 'package:codelab/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());  // Inisialisasi AuthController di awal
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase Auth',
      initialRoute: AppPages.INITIAL, // Initial route from app_pages.dart
      getPages: AppPages.routes,      // GetX routes
    );
  }
}
