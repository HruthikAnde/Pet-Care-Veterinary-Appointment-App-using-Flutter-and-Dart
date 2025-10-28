import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final String petName;
  final VoidCallback? onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.petName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(appointment.status),
          child: Icon(
            _getStatusIcon(appointment.status),
            color: Colors.white,
          ),
        ),
        title: Text(appointment.type),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$petName with Dr. ${appointment.vetName}'),
            Text('${DateFormat('MMM d, yyyy').format(appointment.date)} at ${appointment.time}'),
            Text('\$${appointment.amount}'),
          ],
        ),
        trailing: Chip(
          label: Text(
            appointment.status,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          backgroundColor: _getStatusColor(appointment.status),
        ),
        onTap: onTap,
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