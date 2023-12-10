import 'package:json_annotation/json_annotation.dart';

part 'medicine_model.g.dart';

@JsonSerializable()
class DrugModel {
  final int drugID;
  final String drugName;
  final String drugDescription;
  final String drugPerscription;
  final int holdingPharmacies;
  final bool drugIsConflicting;
  final List<String> drugImages;

  DrugModel(
      {required this.drugID,
        required this.drugName,
        required this.drugDescription,
        required this.drugPerscription,
        required this.holdingPharmacies,
        required this.drugIsConflicting,
        required this.drugImages});

  factory DrugModel.fromJson(Map<String, dynamic> json) {
    return _$DrugModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DrugModelToJson(this);
}

