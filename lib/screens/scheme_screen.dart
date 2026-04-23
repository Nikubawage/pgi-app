import 'package:flutter/material.dart';
import '../models/person.dart';
import 'beneficiary_screen.dart';

class SchemeScreen extends StatelessWidget {
  final List<Person> persons;

  const SchemeScreen({super.key, required this.persons});

  @override
  Widget build(BuildContext context) {
    final schemes = persons.expand((e) => e.schemes).toSet().toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Schemes")),
      body: ListView.builder(
        itemCount: schemes.length,
        itemBuilder: (_, i) {
          final s = schemes[i];

          return ListTile(
            title: Text(s),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BeneficiaryScreen(
                    persons: persons.where((e) => e.schemes.contains(s)).toList(),
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
