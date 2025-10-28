import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Map<String, bool> _services = {
    'General Checkup': true,
    'Vaccination': false,
    'Dental Care': false,
    'Surgery': false,
    'Grooming': false,
    'Emergency Care': true,
    'Dermatology': false,
  };

  Map<String, bool> _vetTypes = {
    'General Practitioner': true,
    'Surgeon': false,
    'Dental Specialist': false,
    'Dermatologist': false,
    'Emergency Specialist': true,
  };

  Map<String, bool> _status = {
    'Scheduled': true,
    'Completed': false,
    'Cancelled': false,
    'Confirmed': true,
  };

  double _distance = 10.0;
  bool _availability = true;
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();

  void _applyFilters() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Filters applied successfully')),
    );
    Navigator.pop(context);
  }

  void _resetFilters() {
    setState(() {
      _services = _services.map((key, value) => MapEntry(key, false));
      _vetTypes = _vetTypes.map((key, value) => MapEntry(key, false));
      _status = _status.map((key, value) => MapEntry(key, false));
      _distance = 50.0;
      _availability = false;
      _startDate = DateTime.now().subtract(Duration(days: 365));
      _endDate = DateTime.now();
    });
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ..._services.keys.map((service) => CheckboxListTile(
              title: Text(service),
              value: _services[service],
              onChanged: (value) {
                setState(() {
                  _services[service] = value!;
                });
              },
              contentPadding: EdgeInsets.zero,
            )),

            SizedBox(height: 20),
            Text(
              'Veterinarian Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ..._vetTypes.keys.map((type) => CheckboxListTile(
              title: Text(type),
              value: _vetTypes[type],
              onChanged: (value) {
                setState(() {
                  _vetTypes[type] = value!;
                });
              },
              contentPadding: EdgeInsets.zero,
            )),

            SizedBox(height: 20),
            Text(
              'Appointment Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ..._status.keys.map((status) => CheckboxListTile(
              title: Text(status),
              value: _status[status],
              onChanged: (value) {
                setState(() {
                  _status[status] = value!;
                });
              },
              contentPadding: EdgeInsets.zero,
            )),

            SizedBox(height: 20),
            Text(
              'Date Range',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _selectStartDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(
                          text: DateFormat('MMM d, yyyy').format(_startDate)
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _selectEndDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(
                          text: DateFormat('MMM d, yyyy').format(_endDate)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Text(
              'Distance (${_distance.round()} km)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _distance,
              min: 1,
              max: 50,
              divisions: 49,
              onChanged: (value) {
                setState(() {
                  _distance = value;
                });
              },
            ),

            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Available Today'),
              subtitle: Text('Show only available slots for today'),
              value: _availability,
              onChanged: (value) {
                setState(() {
                  _availability = value;
                });
              },
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Apply Filters'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}