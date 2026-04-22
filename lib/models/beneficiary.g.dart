// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'beneficiary.dart';

class BeneficiaryAdapter extends TypeAdapter<Beneficiary> {
  @override
  final int typeId = 0;

  @override
  Beneficiary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Beneficiary(
      name: fields[0] as String,
      age: fields[1] as int,
      village: fields[2] as String,
      taluka: fields[3] as String,
      district: fields[4] as String,
      electionCircle: fields[5] as String,
      schemes: (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Beneficiary obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.village)
      ..writeByte(3)
      ..write(obj.taluka)
      ..writeByte(4)
      ..write(obj.district)
      ..writeByte(5)
      ..write(obj.electionCircle)
      ..writeByte(6)
      ..write(obj.schemes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BeneficiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
