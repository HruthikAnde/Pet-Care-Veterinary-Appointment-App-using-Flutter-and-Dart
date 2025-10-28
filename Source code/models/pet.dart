import 'medical_record.dart';

class Pet {
  final String id;
  final String name;
  final String type;
  final String breed;
  final int age;
  final double weight;
  final String? imageUrl;
  final List<MedicalRecord> medicalRecords;

  Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.weight,
    this.imageUrl,
    this.medicalRecords = const [],
  });
}