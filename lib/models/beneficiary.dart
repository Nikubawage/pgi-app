class Beneficiary {
  final String beneficiaryName;
  final String aadhaarNo;
  final String villageName;
  final String schemeName;
  final String talukaName;
  final String districtName;

  Beneficiary({
    required this.beneficiaryName,
    required this.aadhaarNo,
    required this.villageName,
    required this.schemeName,
    required this.talukaName,
    required this.districtName,
  });

  Beneficiary copyWith({String? schemeName}) {
    return Beneficiary(
      beneficiaryName: beneficiaryName,
      aadhaarNo: aadhaarNo,
      villageName: villageName,
      schemeName: schemeName ?? this.schemeName,
      talukaName: talukaName,
      districtName: districtName,
    );
  }
}