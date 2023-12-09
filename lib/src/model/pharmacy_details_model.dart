class PharmacyDetailsModel {
  final String pharmacyId;
  final String pharmacyName;
  final String pharmacyEmail;
  final String pharmacyDescription;
  final String pharmacyImage;
  final String pharmacyArea;
  final String pharmacyDistance;
  final DateTime pharmacyOpeningHours;
  final DateTime pharmacyClosingHours;
  final String pharmacyPhoneNumber;
  // final Location pharmacyLocation;
  // final List<Drug> pharmacyDrugs;
  // final Pharmacist pharmacyPharmacist;

  PharmacyDetailsModel({
    required this.pharmacyId,
    required this.pharmacyName,
    required this.pharmacyEmail,
    required this.pharmacyDescription,
    required this.pharmacyImage,
    required this.pharmacyArea,
    required this.pharmacyDistance,
    required this.pharmacyOpeningHours,
    required this.pharmacyClosingHours,
    required this.pharmacyPhoneNumber,
    // required this.pharmacyLocation,
    // required this.pharmacyDrugs,
    // required this.pharmacyPharmacist,
  });
}
