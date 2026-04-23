import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../models/person.dart';
import '../services/excel_service.dart';
import '../data/app_data.dart'; // ✅ NEW
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool isEnglish = true;

  // 📥 Upload Excel (FIXED)
  Future<void> uploadExcel() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      List<Person> data = ExcelService.parseExcel(file);

      // 🔥 IMPORTANT: store globally + merge
      AppData.setData(data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Loaded ${data.length} records | Total: ${AppData.persons.length}",
          ),
        ),
      );
    }
  }

  // 🌐 Language toggle
  void toggleLanguage(bool value) {
    setState(() {
      isEnglish = value;
    });
  }

  // 🔐 Logout
  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 📂 Upload Excel
            sectionTitle("Admin Actions"),

            ElevatedButton(
              onPressed: uploadExcel,
              child: const Text("Upload Excel"),
            ),

            const SizedBox(height: 20),

            // 🌐 Language
            sectionTitle("Language"),

            SwitchListTile(
              title: Text(isEnglish ? "English" : "मराठी"),
              value: isEnglish,
              onChanged: toggleLanguage,
            ),

            const SizedBox(height: 20),

            // 🔐 Logout
            sectionTitle("Account"),

            ElevatedButton(
              onPressed: logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Section Title
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}