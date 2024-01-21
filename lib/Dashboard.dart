import 'package:flutter/material.dart';
import 'AddComplaintPage.dart';
import 'EditComplaint.dart';
import 'RemoveComplaint.dart';
import 'CheckStatus.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.indigo,

      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo, Colors.blue],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'COMPLAIN MANAGEMENT',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFeatureCard(context, 'Add Complaint', Icons.add, Colors.indigoAccent),
                  SizedBox(height: 16),
                  // _buildFeatureCard(context, 'Edit Complaint', Icons.edit, Colors.green),
                  // SizedBox(height: 16),
                  // _buildFeatureCard(context, 'Remove Complaint', Icons.delete, Colors.red),
                  // SizedBox(height: 16),
                  _buildFeatureCard(context, 'Check Complaint Status', Icons.search, Colors.indigoAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String text, IconData icon, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          if (text == 'Add Complaint') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddComplaintPage()));
          }
          if (text == 'Edit Complaint') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditComplaintPage()));
          }
          if (text == 'Remove Complaint') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RemoveComplaintPage()));
          }

          if (text == 'Check Complaint Status') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CheckComplaintStatusPage()));
          }
          // Handle other feature card taps if needed
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Dashboard(),
  ));
}
