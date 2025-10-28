import 'package:flutter/material.dart';
import '../models/medical_record.dart';

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordCard({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        _getMedicalRecordIcon(record.type),
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(record.type),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(record.description),
          if (record.medication != null) Text('Medication: ${record.medication}'),
          Text(
            '${record.date}',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  IconData _getMedicalRecordIcon(String type) {
    switch (type.toLowerCase()) {
      case 'vaccination':
        return Icons.medical_services;
      case 'checkup':
        return Icons.health_and_safety;
      case 'surgery':
        return Icons.medical_services_outlined;
      default:
        return Icons.medical_information;
    }
  }
}