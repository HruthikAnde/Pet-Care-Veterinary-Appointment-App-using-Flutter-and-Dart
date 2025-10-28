import 'package:flutter/material.dart';
import 'package:myflutterapp/widgets/pet_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../providers/theme_provider.dart'; // Add this import
import '../models/pet.dart';
import 'booking_history_screen.dart';
import 'profile_screen.dart';
import 'pet_detail_screen.dart';
import 'booking_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Care'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          // Add theme toggle button
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.white,
                ),
                onPressed: () {
                  themeProvider.toggleTheme(!themeProvider.isDarkMode);
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingHistoryScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      // ... rest of your existing home screen code remains the same
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            padding: EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${provider.currentUser?.name ?? 'User'}!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'How can we help your pet today?',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Upcoming Appointments
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Appointments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingHistoryScreen()),
                    );
                  },
                  child: Text('View All'),
                ),
              ],
            ),
          ),
          _buildUpcomingAppointments(provider),

          // My Pets Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Pets',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _showAddPetDialog(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildPetsList(provider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingFormScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  // ... rest of your existing home screen methods remain the same
  Widget _buildUpcomingAppointments(AppProvider provider) {
    final upcoming = provider.getUpcomingAppointments();
    if (upcoming.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'No upcoming appointments',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: upcoming.length,
        itemBuilder: (context, index) {
          final appointment = upcoming[index];
          final pet = provider.pets.firstWhere(
            (p) => p.id == appointment.petId,
            orElse: () => Pet(
              id: '',
              name: 'Unknown',
              type: '',
              breed: '',
              age: 0,
              weight: 0,
            ),
          );

          return Container(
            width: 280,
            margin: EdgeInsets.only(right: 12),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      appointment.type,
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${DateFormat('MMM d, yyyy').format(appointment.date)} at ${appointment.time}',
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Dr. ${appointment.vetName}',
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
Widget _buildPetsList(AppProvider provider) {
  if (provider.pets.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No pets added yet',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the + button to add your first pet',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  return ListView.builder(
    itemCount: provider.pets.length,
    itemBuilder: (context, index) {
      final pet = provider.pets[index];
      return PetCard(
        pet: pet,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetDetailScreen(pet: pet),
            ),
          );
        },
      );
    },
  );
}


  void _showAddPetDialog(BuildContext context) {
    final nameController = TextEditingController();
    final typeController = TextEditingController();
    final breedController = TextEditingController();
    final ageController = TextEditingController();
    final weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Pet'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Pet Name'),
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Type (Dog, Cat, etc.)'),
              ),
              TextField(
                controller: breedController,
                decoration: InputDecoration(labelText: 'Breed'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age (years)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
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
              provider.addPet(Pet(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                type: typeController.text,
                breed: breedController.text,
                age: int.tryParse(ageController.text) ?? 0,
                weight: double.tryParse(weightController.text) ?? 0.0,
              ));
              Navigator.pop(context);
            },
            child: Text('Add Pet'),
          ),
        ],
      ),
    );
  }
}