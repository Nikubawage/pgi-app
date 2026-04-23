import 'package:hive/hive.dart';
import '../models/person.dart';

class AppData {
  static List<Person> persons = [];

  static final box = Hive.box('pgi_data');

  // 🔥 LOAD DATA ON APP START
  static void loadData() {
    final stored = box.get('persons');

    if (stored != null) {
      persons = (stored as List)
          .map((e) => Person(
                name: e['name'],
                mobile: e['mobile'],
                aadhaar: e['aadhaar'],
                village: e['village'],
                taluka: e['taluka'],
                district: e['district'],
                gender: e['gender'],
                disabilityType: e['disability'],
                schemes: List<String>.from(e['schemes']),
                totalAmount: e['amount'],
              ))
          .toList();
    }
  }

  // 🔥 SAVE DATA
  static void saveData() {
    final data = persons.map((p) => {
      'name': p.name,
      'mobile': p.mobile,
      'aadhaar': p.aadhaar,
      'village': p.village,
      'taluka': p.taluka,
      'district': p.district,
      'gender': p.gender,
      'disability': p.disabilityType,
      'schemes': p.schemes,
      'amount': p.totalAmount,
    }).toList();

    box.put('persons', data);
  }

  // 🔥 MERGE + SAVE
  static void setData(List<Person> newData) {

    for (var newPerson in newData) {

      bool exists = persons.any((p) =>
        p.aadhaar.isNotEmpty &&
        p.aadhaar == newPerson.aadhaar
      );

      if (!exists) {
        persons.add(newPerson);
      }
    }

    saveData(); // 🔥 important
  }
}