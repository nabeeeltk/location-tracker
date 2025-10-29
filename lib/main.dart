import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // ✅ Initialize Firebase with platform-specific options
    await Firebase.initializeApp(
     
    );
  } catch (e) {
    // You can log or handle Firebase initialization errors here
    debugPrint('🔥 Firebase initialization error: $e');
  }

  runApp(const AdvancedLocationApp());
}
