class Medicine {
  final int medicineID;
  final String name;
  final String description;
  final String perscription;
  final int pharmacies;
  final bool isConflicting;
  final List<String> images;

  Medicine(this.medicineID, this.name, this.description, this.perscription,
      this.pharmacies, this.isConflicting, this.images);
}
