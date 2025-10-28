class MedicalRecord {
  final String id;
  final DateTime date;
  final String description;
  final String type;
  final String? medication;

  MedicalRecord({
    required this.id,
    required this.date,
    required this.description,
    required this.type,
    this.medication,
  });
}