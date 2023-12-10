import 'package:json_annotation/json_annotation.dart';
part 'pharmacist_model.g.dart';

@JsonSerializable()
class PharmacistModel {
  String first_name;
  String last_name;

  PharmacistModel({
    required this.first_name,
    required this.last_name,
  });

  factory PharmacistModel.fromJson(Map<String, dynamic> json) {
    return _$PharmacistModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PharmacistModelToJson(this);
}
