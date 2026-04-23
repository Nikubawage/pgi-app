import 'package:flutter/material.dart';
import '../models/person.dart';

class ReportsScreen extends StatelessWidget {
  final List<Person> persons;

  const ReportsScreen({super.key, required this.persons});

  @override
  Widget build(BuildContext context) {

    // 📊 TOP VILLAGES (by count)
    Map<String, int> villageCount = {};
    Map<String, double> villageAmount = {};

    for (var p in persons) {
      villageCount[p.village] =
          (villageCount[p.village] ?? 0) + 1;

      villageAmount[p.village] =
          (villageAmount[p.village] ?? 0) + p.totalAmount;
    }

    // 📊 TOP SCHEMES
    Map<String, int> schemeCount = {};

    for (var p in persons) {
      for (var s in p.schemes) {
        schemeCount[s] = (schemeCount[s] ?? 0) + 1;
      }
    }

    // 📊 TOP INDIVIDUALS
    List<Person> topPersons = [...persons];
    topPersons.sort((a, b) =>
        b.schemeCount.compareTo(a.schemeCount));

    return Scaffold(
      appBar: AppBar(title: const Text("Reports & Insights")),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [

          sectionTitle("Top Villages (Beneficiaries)"),

          ...villageCount.entries
              .toList()
              ..sort((a, b) => b.value.compareTo(a.value))
              ..take(5)
              ..map((e) => tile(e.key, "Count: ${e.value}")),

          const SizedBox(height: 20),

          sectionTitle("Top Villages (Amount)"),

          ...villageAmount.entries
              .toList()
              ..sort((a, b) => b.value.compareTo(a.value))
              ..take(5)
              ..map((e) => tile(e.key, "₹${e.value.toStringAsFixed(0)}")),

          const SizedBox(height: 20),

          sectionTitle("Top Schemes"),

          ...schemeCount.entries
              .toList()
              ..sort((a, b) => b.value.compareTo(a.value))
              ..take(5)
              ..map((e) => tile(e.key, "Users: ${e.value}")),

          const SizedBox(height: 20),

          sectionTitle("Top Individuals"),

          ...topPersons
              .take(5)
              .map((p) => tile(
                    p.name,
                    "Schemes: ${p.schemeCount} | ₹${p.totalAmount.toStringAsFixed(0)}",
                  )),
        ],
      ),
    );
  }

  // 🔹 Section title
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🔹 List tile
  Widget tile(String title, String subtitle) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}