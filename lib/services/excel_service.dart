import 'package:excel/excel.dart';
import 'dart:io';
import '../models/person.dart';

class ExcelService {

  static List<Person> parseExcel(File file) {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    var sheet = excel.tables[excel.tables.keys.first]!;

    // 🔥 Map for grouping persons
    Map<String, Person> personMap = {};

    for (int i = 1; i < sheet.maxRows; i++) {
      var row = sheet.row(i);

      if (row.isEmpty) continue;

      // 📊 Column mapping (based on your Excel)
      String name = getValue(row, 2);
      String mobile = getValue(row, 4);
      String aadhaar = getValue(row, 5);
      String scheme = getValue(row, 6);
      String village = getValue(row, 9);
      String taluka = getValue(row, 10);
      String district = getValue(row, 11);
      String gender = getValue(row, 17);
      String disability = getValue(row, 18);

      double amount =
          double.tryParse(getValue(row, 16)) ?? 0.0;

      // 🔑 UNIQUE KEY LOGIC (VERY IMPORTANT)
      String key = "";

      if (aadhaar.isNotEmpty) {
        key = aadhaar;
      } else if (mobile.isNotEmpty) {
        key = mobile;
      } else {
        key = "$name-$village";
      }

      // 🧠 Create new person if not exists
      if (!personMap.containsKey(key)) {
        personMap[key] = Person(
          name: name,
          mobile: mobile,
          aadhaar: aadhaar,
          village: village,
          taluka: taluka,
          district: district,
          gender: gender,
          disabilityType: disability,
        );
      }

      var person = personMap[key]!;

      // ➕ Add scheme (no duplicate)
      person.addScheme(scheme);

      // ➕ Add amount
      person.addAmount(amount);
    }

    return personMap.values.toList();
  }

  // 🔒 Safe cell value getter
  static String getValue(List<Data?> row, int index) {
    if (index < 0 || index >= row.length) return "";
    return row[index]?.value.toString().trim() ?? "";
  }
}