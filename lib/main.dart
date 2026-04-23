import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/login_screen.dart';
import 'data/app_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open storage box
  await Hive.openBox('pgi_data');

  // Load saved data
  AppData.loadData();

  runApp(const PGIApp());
}

class PGIApp extends StatelessWidget {
  const PGIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P-GI',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A11CB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),

      home: const LoginScreen(),
    );
  }
}