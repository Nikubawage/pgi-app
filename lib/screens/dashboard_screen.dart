import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/person.dart';

import 'beneficiary_screen.dart';
import 'village_screen.dart';
import 'scheme_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<Person> persons = [];

  @override
  void initState() {
    super.initState();
    persons = AppData.persons;
  }

  @override
  Widget build(BuildContext context) {

    int total = persons.length;
    int villages = persons.map((e) => e.village).toSet().length;
    int schemes = persons.expand((e) => e.schemes).toSet().length;
    int high = persons.where((e) => e.isHighBeneficiary).length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            // 🔥 HEADER (LIKE YOUR DESIGN)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2A0845), Color(0xFF6A11CB)],
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(35)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome,",
                          style: TextStyle(color: Colors.white70)),
                      Text("Admin",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Maharashtra Beneficiary Insights",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  Row(
                    children: [
                      circleBtn(Icons.language),
                      const SizedBox(width: 10),
                      circleBtn(Icons.logout),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 15),

            // 📊 STATS GRID (COLORFUL LIKE YOUR REF)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: statCard("Beneficiaries", total, Colors.deepPurple)),
                      Expanded(child: statCard("Villages", villages, Colors.green)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: statCard("Schemes", schemes, Colors.orange)),
                      Expanded(child: statCard("High Benefit", high, Colors.pink)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 DASHBOARD SECTION TITLE
            sectionTitle("Dashboard"),

            // 🔥 BENEFICIARY MANAGEMENT (MAIN CARD)
            bigCard(
              icon: Icons.people,
              title: "Beneficiary Management",
              subtitle: "Tap to view details",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => BeneficiaryScreen(persons: persons)));
              },
            ),

            // 🔥 SECOND ROW
            Row(
              children: [
                Expanded(
                  child: colorCard("Reports & Insights", Icons.bar_chart, Colors.green, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AnalyticsScreen(persons: persons)));
                  }),
                ),
                Expanded(
                  child: colorCard("Settings", Icons.settings, Colors.orange, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SettingsScreen()));
                  }),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // 🔥 QUICK ACTIONS
            sectionTitle("Quick Actions"),

            Row(
              children: [
                Expanded(child: actionCard("Search", Icons.search, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => BeneficiaryScreen(persons: persons)));
                })),
                Expanded(child: actionCard("Village-wise", Icons.location_city, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => VillageScreen(persons: persons)));
                })),
              ],
            ),

            Row(
              children: [
                Expanded(child: actionCard("Scheme-wise", Icons.list, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SchemeScreen(persons: persons)));
                })),
                Expanded(child: actionCard("High Benefit", Icons.star, () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => BeneficiaryScreen(
                              persons: persons.where((e) => e.isHighBeneficiary).toList())));
                })),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 🔵 STAT CARD
  Widget statCard(String title, int value, Color color) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(value.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 22)),
          Text(title,
              style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  // 🔵 BIG CARD
  Widget bigCard({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A44FF), Color(0xFF6A11CB)],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 35),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white70)),
              ],
            )
          ],
        ),
      ),
    );
  }

  // 🔵 COLORED CARD
  Widget colorCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // 🔵 ACTION CARD
  Widget actionCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // 🔵 HEADER BUTTON
  Widget circleBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
