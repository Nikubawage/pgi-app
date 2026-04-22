import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/beneficiary.dart';

class ExcelService {
  static Future<void> importExcelData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null && result.files.single.path != null) {
      var bytes = File(result.files.single.path!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      
      var box = Hive.box<Beneficiary>('beneficiaries');
      await box.clear();

      for (var table in excel.tables.keys) {
        var rows = excel.tables[table]!.rows;
        
        for (int i = 1; i < rows.length; i++) {
          var row = rows[i];
          if (row[0] == null) continue;

          String schemeString = row[6]?.value?.toString() ?? '';
          List<String> parsedSchemes = schemeString.isEmpty 
              ? [] 
              : schemeString.split(',').map((e) => e.trim()).toList();

          final beneficiary = Beneficiary(
            name: row[0]?.value?.toString() ?? 'Unknown',
            age: int.tryParse(row[1]?.value?.toString() ?? '0') ?? 0,
            village: row[2]?.value?.toString() ?? '',
            taluka: row[3]?.value?.toString() ?? '',
            district: row[4]?.value?.toString() ?? '',
            electionCircle: row[5]?.value?.toString() ?? '',
            schemes: parsedSchemes,
          );
          
          await box.add(beneficiary);
        }
        break; 
      }
    }
  }
}
