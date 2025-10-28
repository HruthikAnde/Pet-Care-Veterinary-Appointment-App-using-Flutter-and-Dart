import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../providers/theme_provider.dart'; // Add this import
import 'home_screen.dart';
import 'booking_history_screen.dart';
import 'login_signup_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                (route) => false,
              );
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: provider.currentUser == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Header
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue.shade100,
                            backgroundImage: provider.currentUser!.profileImage != null
                                ? NetworkImage(provider.currentUser!.profileImage!)
                                : null,
                            child: provider.currentUser!.profileImage == null
                                ? Icon(Icons.person, size: 50, color: Colors.blue)
                                : null,
                          ),
                          SizedBox(height: 16),
                          Text(
                            provider.currentUser!.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            provider.currentUser!.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            provider.currentUser!.phone,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Quick Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Pets',
                          provider.pets.length.toString(),
                          Icons.pets,
                          Colors.blue,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Appointments',
                          provider.appointments.length.toString(),
                          Icons.calendar_today,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Upcoming',
                          provider.getUpcomingAppointments().length.toString(),
                          Icons.upcoming,
                          Colors.orange,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Completed',
                          provider.appointments.where((a) => a.status == 'Completed').length.toString(),
                          Icons.check_circle,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Menu Options
                  Card(
                    child: Column(
                      children: [
                        _buildMenuOption(
                          Icons.person,
                          'Personal Information',
                          'Update your personal details',
                          () {},
                        ),
                        _buildMenuOption(
                          Icons.pets,
                          'My Pets',
                          'Manage your pets',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          },
                        ),
                        _buildMenuOption(
                          Icons.medical_services,
                          'Medical Records',
                          'View all medical records',
                          () {},
                        ),
                        _buildMenuOption(
                          Icons.history,
                          'Appointment History',
                          'View your booking history',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookingHistoryScreen()),
                            );
                          },
                        ),
                        _buildMenuOption(
                          Icons.notifications,
                          'Notifications',
                          'Manage your notifications',
                          () {},
                        ),
                        _buildMenuOption(
                          Icons.settings,
                          'Settings',
                          'App settings and preferences',
                          () {},
                        ),
                        _buildMenuOption(
                          Icons.help,
                          'Help & Support',
                          'Get help and support',
                          () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

