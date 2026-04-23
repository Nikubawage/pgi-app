import 'package:flutter/material.dart';
import '../models/person.dart';
import 'beneficiary_screen.dart';

class VillageScreen extends StatelessWidget {
  final List<Person> persons;

  const VillageScreen({super.key, required this.persons});

  @override
  Widget build(BuildContext context) {
    final villages = persons.map((e) => e.village).toSet().toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Villages")),
      body: ListView.builder(
        itemCount: villages.length,
        itemBuilder: (_, i) {
          final v = villages[i];

          return ListTile(
            title: Text(v),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BeneficiaryScreen(
                    persons: persons.where((e) => e.village == v).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}