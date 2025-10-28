import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import 'payment_screen.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPet;
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  String? _selectedService;
  String? _selectedVet;

  final List<String> _services = [
    'General Checkup',
    'Vaccination',
    'Dental Care',
    'Surgery',
    'Grooming',
    'Emergency Care',
    'Dermatology',
  ];

  final List<String> _vets = [
    'Dr. Smith - General Practitioner',
    'Dr. Johnson - Surgeon',
    'Dr. Wilson - Dental Specialist',
    'Dr. Brown - Dermatologist',
    'Dr. Davis - Emergency Care',
  ];

  final List<String> _timeSlots = [
    '09:00 AM', '10:00 AM', '11:00 AM', 
    '02:00 PM', '03:00 PM', '04:00 PM', '05:00 PM'
  ];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            appointmentDetails: {
              'pet': _selectedPet,
              'date': _selectedDate,
              'time': _selectedTime,
              'service': _selectedService,
              'vet': _selectedVet,
              'amount': _calculateAmount(),
            },
          ),
        ),
      );
    }
  }

  double _calculateAmount() {
    switch (_selectedService) {
      case 'General Checkup':
        return 50.0;
      case 'Vaccination':
        return 35.0;
      case 'Dental Care':
        return 80.0;
      case 'Surgery':
        return 200.0;
      case 'Grooming':
        return 25.0;
      case 'Emergency Care':
        return 100.0;
      case 'Dermatology':
        return 60.0;
      default:
        return 50.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Pet',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField(
                        value: _selectedPet,
                        items: provider.pets.map((pet) {
                          return DropdownMenuItem(
                            value: pet.id,
                            child: Text(pet.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedPet = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Choose your pet',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a pet';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date & Time',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: _selectDate,
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Date',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            controller: TextEditingController(
                              text: DateFormat('MMM d, yyyy').format(_selectedDate)
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField(
                        value: _selectedTime,
                        items: _timeSlots.map((time) {
                          return DropdownMenuItem(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedTime = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Time Slot',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a time slot';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service Details',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField(
                        value: _selectedService,
                        items: _services.map((service) {
                          return DropdownMenuItem(
                            value: service,
                            child: Text(service),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedService = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Service Type',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a service';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField(
                        value: _selectedVet,
                        items: _vets.map((vet) {
                          return DropdownMenuItem(
                            value: vet,
                            child: Text(vet),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedVet = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Veterinarian',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a veterinarian';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Spacer(),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Continue to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}