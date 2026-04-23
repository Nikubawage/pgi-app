class Person {
  String name;
  String mobile;
  String aadhaar;
  String village;
  String taluka;
  String district;
  String gender;
  String disabilityType;

  // 🔥 Multiple schemes per person
  List<String> schemes;

  // 💰 Total amount received
  double totalAmount;

  Person({
    required this.name,
    required this.mobile,
    required this.aadhaar,
    required this.village,
    required this.taluka,
    required this.district,
    required this.gender,
    required this.disabilityType,
    List<String>? schemes,
    double? totalAmount,
  })  : schemes = schemes ?? [],
        totalAmount = totalAmount ?? 0.0;

  // 🔢 Total schemes count
  int get schemeCount => schemes.length;

  // 🚨 High Beneficiary Logic
  bool get isHighBeneficiary => schemeCount > 2;

  // ➕ Add scheme safely (no duplicate)
  void addScheme(String scheme) {
    if (!schemes.contains(scheme)) {
      schemes.add(scheme);
    }
  }

  // ➕ Add amount
  void addAmount(double amount) {
    totalAmount += amount;
  }
}