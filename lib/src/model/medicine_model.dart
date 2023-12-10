import 'package:json_annotation/json_annotation.dart';

part 'medicine_model.g.dart';

@JsonSerializable()
class DrugModel {
  //final int drugID;
  final String name;
  final String description;
  // final String drugPerscription;
  // final int holdingPharmacies;
  // final bool drugIsConflicting;
  // final List<String> drugImages;

  DrugModel(
      {
        //required this.id,
        required this.name,
        required this.description,
        // required this.drugPerscription,
        // required this.holdingPharmacies,
        // required this.drugIsConflicting,
        // required this.drugImages
      });

  factory DrugModel.fromJson(Map<String, dynamic> json) {
    return _$DrugModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DrugModelToJson(this);
}

