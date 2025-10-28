import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/pet.dart';
import '../models/appointment.dart';
import '../models/medical_record.dart';

class AppProvider with ChangeNotifier {
  User? _currentUser;
  List<Pet> _pets = [];
  List<Appointment> _appointments = [];
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  List<Pet> get pets => _pets;
  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;

  AppProvider() {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    _pets = [
      Pet(
        id: '1',
        name: 'Buddy',
        type: 'Dog',
        breed: 'Golden Retriever',
        age: 3,
        weight: 25.5,
        medicalRecords: [
          MedicalRecord(
            id: '1',
            date: DateTime(2024, 1, 15),
            description: 'Annual Checkup',
            type: 'Checkup',
            medication: 'None',
          ),
          MedicalRecord(
            id: '2',
            date: DateTime(2024, 2, 20),
            description: 'Rabies Vaccination',
            type: 'Vaccination',
            medication: 'Rabies Vaccine',
          ),
        ],
      ),
      Pet(
        id: '2',
        name: 'Whiskers',
        type: 'Cat',
        breed: 'Siamese',
        age: 2,
        weight: 4.2,
      ),
    ];

    _appointments = [
      Appointment(
        id: '1',
        petId: '1',
        date: DateTime(2024, 3, 20),
        time: '10:00 AM',
        vetName: 'Dr. Smith',
        clinic: 'City Veterinary Clinic',
        type: 'General Checkup',
        status: 'Scheduled',
        amount: 50.0,
      ),
      Appointment(
        id: '2',
        petId: '2',
        date: DateTime(2024, 2, 15),
        time: '02:00 PM',
        vetName: 'Dr. Johnson',
        clinic: 'Animal Care Center',
        type: 'Vaccination',
        status: 'Completed',
        amount: 35.0,
      ),
    ];

    _currentUser = User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: '+1234567890',
    );
  }

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void addPet(Pet pet) {
    _pets.add(pet);
    notifyListeners();
  }

  void bookAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  List<Appointment> getUpcomingAppointments() {
    return _appointments.where((appt) => 
      appt.date.isAfter(DateTime.now())).toList();
  }

  void addMedicalRecord(String petId, MedicalRecord record) {
    final petIndex = _pets.indexWhere((pet) => pet.id == petId);
    if (petIndex != -1) {
      _pets[petIndex].medicalRecords.add(record);
      notifyListeners();
    }
  }
}