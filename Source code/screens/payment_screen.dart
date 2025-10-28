import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/appointment.dart';
import 'booking_confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> appointmentDetails;

  const PaymentScreen({super.key, required this.appointmentDetails});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'card';
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

  void _processPayment() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    
    final appointment = Appointment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      petId: widget.appointmentDetails['pet'],
      date: widget.appointmentDetails['date'],
      time: widget.appointmentDetails['time'],
      vetName: widget.appointmentDetails['vet'].toString().split(' - ')[0],
      clinic: 'City Veterinary Clinic',
      type: widget.appointmentDetails['service'],
      status: 'Scheduled',
      amount: widget.appointmentDetails['amount'],
    );
    
    provider.bookAppointment(appointment);
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmationScreen(
          appointmentDetails: widget.appointmentDetails,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appointment Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildSummaryRow('Service', widget.appointmentDetails['service']),
                    _buildSummaryRow('Veterinarian', widget.appointmentDetails['vet']),
                    _buildSummaryRow('Date', DateFormat('MMM d, yyyy').format(widget.appointmentDetails['date'])),
                    _buildSummaryRow('Time', widget.appointmentDetails['time']),
                    SizedBox(height: 8),
                    Divider(),
                    _buildSummaryRow(
                      'Total Amount',
                      '\$${widget.appointmentDetails['amount']}',
                      isBold: true,
                      valueColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _buildPaymentMethod(
              'Credit/Debit Card',
              'card',
              Icons.credit_card,
            ),
            _buildPaymentMethod(
              'PayPal',
              'paypal',
              Icons.payment,
            ),
            _buildPaymentMethod(
              'Google Pay',
              'googlepay',
              Icons.payment,
            ),
            _buildPaymentMethod(
              'Apple Pay',
              'applepay',
              Icons.payment,
            ),

            if (_selectedPaymentMethod == 'card') ...[
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Details',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _cardHolderController,
                        decoration: InputDecoration(
                          labelText: 'Card Holder Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _cardNumberController,
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _expiryController,
                              decoration: InputDecoration(
                                labelText: 'Expiry Date',
                                border: OutlineInputBorder(),
                                hintText: 'MM/YY',
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _cvvController,
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _processPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Pay \$${widget.appointmentDetails['amount']}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(String title, String value, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: RadioListTile(
        title: Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 12),
            Text(title),
          ],
        ),
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            _selectedPaymentMethod = value!;
          });
        },
      ),
    );
  }
}