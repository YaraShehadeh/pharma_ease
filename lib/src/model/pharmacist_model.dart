import 'package:json_annotation/json_annotation.dart';
part 'pharmacist_model.g.dart';

@JsonSerializable()
class PharmacistModel {
  String pharmacistFName;
  String pharmacistLName;

  PharmacistModel({
    required this.pharmacistFName,
    required this.pharmacistLName,
  });

  factory PharmacistModel.fromJson(Map<String, dynamic> json) {
    return _$PharmacistModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PharmacistModelToJson(this);
}
