import 'package:flutter/material.dart';
import 'package:myflutterapp/widgets/medical_record_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/pet.dart';
import '../models/medical_record.dart';

class PetDetailScreen extends StatelessWidget {
  final Pet pet;

  const PetDetailScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        actions: [
          IconButton(
            icon: Icon(Icons.medical_services),
            onPressed: () {
              _showAddMedicalRecordDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: pet.imageUrl != null 
                    ? NetworkImage(pet.imageUrl!) 
                    : null,
                child: pet.imageUrl == null 
                    ? Icon(Icons.pets, size: 60, color: Colors.blue) 
                    : null,
              ),
            ),
            SizedBox(height: 20),
            
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Basic Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow('Name', pet.name),
                    _buildInfoRow('Type', pet.type),
                    _buildInfoRow('Breed', pet.breed),
                    _buildInfoRow('Age', '${pet.age} years'),
                    _buildInfoRow('Weight', '${pet.weight} kg'),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Medical Records',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${pet.medicalRecords.length} records',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                     if (pet.medicalRecords.isEmpty)
  Center(
    child: Text(
      'No medical records yet',
      style: TextStyle(color: Colors.grey),
    ),
  )
else
  ...pet.medicalRecords.map((record) => MedicalRecordCard(record: record)).toList(),  
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
          ),
          SizedBox(width: 8),
          Text(value),
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

  void _showAddMedicalRecordDialog(BuildContext context) {
    final typeController = TextEditingController();
    final descriptionController = TextEditingController();
    final medicationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Medical Record'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Record Type'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextField(
                controller: medicationController,
                decoration: InputDecoration(labelText: 'Medication (optional)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final provider = Provider.of<AppProvider>(context, listen: false);
              provider.addMedicalRecord(pet.id, MedicalRecord(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                date: DateTime.now(),
                description: descriptionController.text,
                type: typeController.text,
                medication: medicationController.text.isEmpty ? null : medicationController.text,
              ));
              Navigator.pop(context);
            },
            child: Text('Add Record'),
          ),
        ],
      ),
    );
  }
}