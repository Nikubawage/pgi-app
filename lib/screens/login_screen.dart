import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passController = TextEditingController();
  String error = "";

  void login() {
    if (emailController.text == "admin@pgi.in" &&
        passController.text == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      setState(() => error = "Invalid credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text("PGI Login", style: TextStyle(fontSize: 22)),

              TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
              TextField(controller: passController, obscureText: true, decoration: const InputDecoration(labelText: "Password")),

              if (error.isNotEmpty)
                Text(error, style: const TextStyle(color: Colors.red)),

              ElevatedButton(onPressed: login, child: const Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}