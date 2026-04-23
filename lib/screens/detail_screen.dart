import 'package:flutter/material.dart';
import '../models/person.dart';

class DetailScreen extends StatelessWidget {
  final Person person;

  const DetailScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Beneficiary Details"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔴 HIGH BENEFICIARY TAG
            if (person.isHighBeneficiary)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "HIGH BENEFICIARY",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),

            // 👤 BASIC INFO
            sectionTitle("Basic Info"),

            info("Name", person.name),
            info("Mobile", person.mobile),
            info("Aadhaar", person.aadhaar),

            const SizedBox(height: 15),

            // 📍 LOCATION
            sectionTitle("Location"),

            info("Village", person.village),
            info("Taluka", person.taluka),
            info("District", person.district),

            const SizedBox(height: 15),

            // 🧍 OTHER INFO
            sectionTitle("Other Info"),

            info("Gender", person.gender),
            info("Disability", person.disabilityType),

            const SizedBox(height: 15),

            // 📊 SCHEMES
            sectionTitle("Schemes"),

            ...person.schemes.map((s) =>
              ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text(s),
              )
            ),

            const SizedBox(height: 10),

            // 📊 SUMMARY
            sectionTitle("Summary"),

            info("Total Schemes", person.schemeCount.toString()),
            info("Total Amount", "₹${person.totalAmount.toStringAsFixed(0)}"),

            const SizedBox(height: 20),

            // 🖨 ACTION BUTTONS
            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Print Coming Soon")),
                      );
                    },
                    child: const Text("Print"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Share Coming Soon")),
                      );
                    },
                    child: const Text("Share"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // 🔹 Section Title
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🔹 Key-Value UI
  Widget info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(label,
                  style: const TextStyle(color: Colors.grey))),
          Expanded(
              flex: 5,
              child: Text(value,
                  style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}