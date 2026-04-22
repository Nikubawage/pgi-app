import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/beneficiary.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Offline Database
  await Hive.initFlutter();
  Hive.registerAdapter(BeneficiaryAdapter());
  await Hive.openBox<Beneficiary>('beneficiaries');

  runApp(const PgiApp());
}

class PgiApp extends StatelessWidget {
  const PgiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P-GI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6A11CB),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
