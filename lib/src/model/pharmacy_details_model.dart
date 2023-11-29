import 'package:json_annotation/json_annotation.dart';

part 'pharmacy_details_model.g.dart';

@JsonSerializable()
class PharmacyDetailsModel {
  final String pharmacyId;
  final String pharmacyName;
  final String pharmacyEmail;
  final String pharmacyDescription;
  // final Location pharmacyLocation;
  // final List<Drug> pharmacyDrugs;
  // final Pharmacist pharmacyPharmacist;

  PharmacyDetailsModel({
    required this.pharmacyId,
    required this.pharmacyName,
    required this.pharmacyEmail,
    required this.pharmacyDescription,
    // required this.pharmacyLocation,
    // required this.pharmacyDrugs,
    // required this.pharmacyPharmacist,
  });

  factory PharmacyDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$PharmacyDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PharmacyDetailsModelToJson(this);
}
