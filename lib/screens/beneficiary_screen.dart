import 'package:flutter/material.dart';
import '../models/person.dart';
import 'detail_screen.dart';

class BeneficiaryScreen extends StatefulWidget {
  final List<Person> persons;

  const BeneficiaryScreen({super.key, required this.persons});

  @override
  State<BeneficiaryScreen> createState() => _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends State<BeneficiaryScreen> {

  List<Person> filtered = [];
  String searchText = "";
  bool showHighOnly = false;

  @override
  void initState() {
    super.initState();
    filtered = widget.persons;
  }

  void applyFilter() {
    List<Person> temp = widget.persons;

    // 🔍 Search
    if (searchText.isNotEmpty) {
      temp = temp.where((e) =>
          e.name.toLowerCase().contains(searchText.toLowerCase()) ||
          e.mobile.contains(searchText) ||
          e.aadhaar.contains(searchText)
      ).toList();
    }

    // 🚨 High Beneficiary filter
    if (showHighOnly) {
      temp = temp.where((e) => e.isHighBeneficiary).toList();
    }

    setState(() {
      filtered = temp;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Beneficiaries"),
      ),

      body: Column(
        children: [

          // 🔍 SEARCH BOX
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search by Name / Mobile / Aadhaar",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                searchText = value;
                applyFilter();
              },
            ),
          ),

          // 🔘 FILTER SWITCH
          SwitchListTile(
            title: const Text("High Beneficiaries Only"),
            value: showHighOnly,
            onChanged: (val) {
              showHighOnly = val;
              applyFilter();
            },
          ),

          const Divider(),

          // 📊 RESULT COUNT
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("Total: ${filtered.length}"),
          ),

          // 📋 LIST
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {

                final p = filtered[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(p.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${p.village}"),
                        Text("Schemes: ${p.schemeCount}"),
                        Text("Amount: ₹${p.totalAmount.toStringAsFixed(0)}"),
                      ],
                    ),

                    trailing: p.isHighBeneficiary
                        ? const Icon(Icons.warning, color: Colors.red)
                        : null,

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(person: p),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}