class Appointment {
  final String id;
  final String petId;
  final DateTime date;
  final String time;
  final String vetName;
  final String clinic;
  final String type;
  final String status;
  final double amount;

  Appointment({
    required this.id,
    required this.petId,
    required this.date,
    required this.time,
    required this.vetName,
    required this.clinic,
    required this.type,
    this.status = 'Scheduled',
    required this.amount,
  });
}