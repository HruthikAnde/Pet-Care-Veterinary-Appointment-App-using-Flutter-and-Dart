import 'package:flutter/material.dart';
import 'package:myflutterapp/models/pet.dart';
import 'package:myflutterapp/widgets/appointment_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import 'filters_screen.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FiltersScreen()),
              );
            },
          ),
        ],
      ),
      body: provider.appointments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No appointments yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Book your first appointment to get started',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          :ListView.builder(
  itemCount: provider.appointments.length,
  itemBuilder: (context, index) {
    final appointment = provider.appointments[index];
    final pet = provider.pets.firstWhere(
      (p) => p.id == appointment.petId,
      orElse: () => Pet(
        id: '',
        name: 'Unknown Pet',
        type: '',
        breed: '',
        age: 0,
        weight: 0,
      ),
    );

    return AppointmentCard(
      appointment: appointment,
      petName: pet.name,
    );
  },
),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'confirmed':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Icons.schedule;
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'confirmed':
        return Icons.verified;
      default:
        return Icons.help;
    }
  }
}