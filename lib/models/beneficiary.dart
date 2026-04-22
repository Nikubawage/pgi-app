import 'package:hive/hive.dart';

part 'beneficiary.g.dart';

@HiveType(typeId: 0)
class Beneficiary extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final String village;
  @HiveField(3)
  final String taluka;
  @HiveField(4)
  final String district;
  @HiveField(5)
  final String electionCircle;
  @HiveField(6)
  final List<String> schemes;

  Beneficiary({
    required this.name,
    required this.age,
    required this.village,
    required this.taluka,
    required this.district,
    required this.electionCircle,
    required this.schemes,
  });

  int get schemeCount => schemes.length;
  bool get isHighBeneficiary => schemeCount >= 3;
}
