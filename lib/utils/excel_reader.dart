import 'package:excel/excel.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import '../models/beneficiary.dart';

Future<void> readExcel(File file) async {
  var bytes = file.readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  var sheet = excel.tables[excel.tables.keys.first]!;

  final box = Hive.box<Beneficiary>('beneficiaries');

  var headers = sheet.row(0);

  int nameIndex = -1;
  int mobileIndex = -1;
  int villageIndex = -1;
  int ageIndex = -1;
  int aadhaarIndex = -1;
  int addressIndex = -1;

  for (int i = 0; i < headers.length; i++) {
    String header = headers[i]?.value.toString().toLowerCase() ?? "";

    if (header.contains("name")) nameIndex = i;
    if (header.contains("mobile") || header.contains("contact")) mobileIndex = i;
    if (header.contains("village")) villageIndex = i;
    if (header.contains("age")) ageIndex = i;
    if (header.contains("aadhaar")) aadhaarIndex = i;
    if (header.contains("address")) addressIndex = i;
  }

  for (int i = 1; i < sheet.maxRows; i++) {
    var row = sheet.row(i);

    if (row.isEmpty) continue;

    String name = getValue(row, nameIndex);
    String scheme = "Sanjay Gandhi Scheme";
    String mobile = getValue(row, mobileIndex);

    bool exists = box.values.any((e) =>
      e.name.toLowerCase() == name.toLowerCase() &&
      e.scheme.toLowerCase() == scheme.toLowerCase()
    );

    if (!exists) {
      box.add(
        Beneficiary(
          name: name,
          mobile: mobile,
          village: getValue(row, villageIndex),
          scheme: scheme,
          age: getValue(row, ageIndex),
          aadhaar: getValue(row, aadhaarIndex),
          pan: "",
          address: getValue(row, addressIndex),
        ),
      );
    }
  }
}

String getValue(List<Data?> row, int index) {
  if (index < 0 || index >= row.length) return "";
  return row[index]?.value.toString() ?? "";
}