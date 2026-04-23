import 'package:flutter/material.dart';
import '../models/person.dart';

class FiltersScreen extends StatefulWidget {
  final List<Person> persons;

  const FiltersScreen({super.key, required this.persons});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  String? selectedVillage;
  String? selectedScheme;
  String? selectedGender;
  int schemeCountFilter = 0;

  List<Person> filtered = [];

  @override
  void initState() {
    super.initState();
    filtered = AppData.persons;
  }

  void applyFilters() {
    List<Person> temp = AppData.persons;

    if (selectedVillage != null) {
      temp = temp.where((e) => e.village == selectedVillage).toList();
    }

    if (selectedGender != null) {
      temp = temp.where((e) => e.gender == selectedGender).toList();
    }

    if (selectedScheme != null) {
      temp = temp.where((e) => e.schemes.contains(selectedScheme)).toList();
    }

    if (schemeCountFilter > 0) {
      temp = temp.where((e) => e.schemeCount >= schemeCountFilter).toList();
    }

    setState(() {
      filtered = temp;
    });
  }

  @override
  Widget build(BuildContext context) {

    final villages = AppData.persons.map((e) => e.village).toSet().toList();
    final schemes = AppData.persons.expand((e) => e.schemes).toSet().toList();
    final genders = AppData.persons.map((e) => e.gender).toSet().toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Advanced Filters")),

      body: Column(
        children: [

          // 🔽 FILTER UI
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [

                dropdown("Village", villages, selectedVillage, (val) {
                  selectedVillage = val;
                }),

                dropdown("Scheme", schemes, selectedScheme, (val) {
                  selectedScheme = val;
                }),

                dropdown("Gender", genders, selectedGender, (val) {
                  selectedGender = val;
                }),

                const SizedBox(height: 10),

                // 🔢 Scheme Count Filter
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: "Scheme Count",
                    border: OutlineInputBorder(),
                  ),
                  value: schemeCountFilter == 0 ? null : schemeCountFilter,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text("> 1")),
                    DropdownMenuItem(value: 2, child: Text("> 2")),
                    DropdownMenuItem(value: 3, child: Text("> 3")),
                  ],
                  onChanged: (val) {
                    schemeCountFilter = val ?? 0;
                  },
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: applyFilters,
                  child: const Text("Apply Filters"),
                )
              ],
            ),
          ),

          const Divider(),

          // 📊 RESULT COUNT
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("Results: ${filtered.length}"),
          ),

          // 📋 RESULT LIST
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {

                final p = filtered[index];

                return ListTile(
                  title: Text(p.name),
                  subtitle: Text("${p.village} | Schemes: ${p.schemeCount}"),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // 🔽 Reusable Dropdown
  Widget dropdown(
      String label,
      List<String> items,
      String? selected,
      Function(String?) onChanged
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        value: selected,
        items: items.map((e) =>
            DropdownMenuItem(value: e, child: Text(e))
        ).toList(),
        onChanged: onChanged,
      ),
    );
  }
}