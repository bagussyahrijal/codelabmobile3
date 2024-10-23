import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/login_page.dart'; 
import '../views/home_view.dart';  

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
  RxBool isLoading = false.obs; // Loading indicator

  // Fungsi untuk registrasi pengguna baru
  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Registration successful', backgroundColor: Colors.green);
      Get.offAll(() => LoginPage()); // Navigate to Home after registration
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk login pengguna
  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Login successful', backgroundColor: Colors.green);
      Get.offAll(() => HomeView()); // Navigate to Home after login
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk logout
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => LoginPage()); // Redirect to login page after logout
  }

  // Fungsi untuk mendapatkan status autentikasi
  User? get currentUser => _auth.currentUser;
}
