import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/person.dart';

class AnalyticsScreen extends StatelessWidget {
  final List<Person> persons;

  const AnalyticsScreen({super.key, required this.persons});

  @override
  Widget build(BuildContext context) {

    Map<String, int> villageCount = {};
    for (var p in persons) {
      villageCount[p.village] = (villageCount[p.village] ?? 0) + 1;
    }

    Map<String, int> schemeCount = {};
    for (var p in persons) {
      for (var s in p.schemes) {
        schemeCount[s] = (schemeCount[s] ?? 0) + 1;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Analytics")),
      backgroundColor: const Color(0xFFF5F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            chartCard(
              "Village Distribution",
              PieChart(
                PieChartData(
                  sections: villageCount.entries.take(5).map((e) =>
                      PieChartSectionData(
                        value: e.value.toDouble(),
                        title: e.key,
                      )).toList(),
                ),
              ),
            ),

            chartCard(
              "Top Schemes",
              BarChart(
                BarChartData(
                  barGroups: schemeCount.entries.take(5).toList().asMap().entries.map((e) =>
                      BarChartGroupData(
                        x: e.key,
                        barRods: [
                          BarChartRodData(toY: e.value.value.toDouble())
                        ],
                      )).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chartCard(String title, Widget chart) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(height: 220, child: chart),
        ],
      ),
    );
  }
}