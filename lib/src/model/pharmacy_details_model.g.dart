// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PharmacyDetailsModel _$PharmacyDetailsModelFromJson(
        Map<String, dynamic> json) =>
    PharmacyDetailsModel(
      pharmacyId: json['pharmacyId'] as String,
      pharmacyName: json['pharmacyName'] as String,
      pharmacyEmail: json['pharmacyEmail'] as String,
      pharmacyDescription: json['pharmacyDescription'] as String,
    );

Map<String, dynamic> _$PharmacyDetailsModelToJson(
        PharmacyDetailsModel instance) =>
    <String, dynamic>{
      'pharmacyId': instance.pharmacyId,
      'pharmacyName': instance.pharmacyName,
      'pharmacyEmail': instance.pharmacyEmail,
      'pharmacyDescription': instance.pharmacyDescription,
    };
