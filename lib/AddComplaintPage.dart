import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddComplaintPage extends StatelessWidget {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Complaint',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'COMPLAINT SYSTEM',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
              ),
              SizedBox(height: 24),
              _buildInputField('Subject of Complaint', subjectController),
              SizedBox(height: 16),
              _buildLargeInputField('Complaint Message', messageController),
              SizedBox(height: 16),
              _buildInputField('Name', nameController),
              SizedBox(height: 16),
              _buildInputField('Father Name', fatherNameController),
              SizedBox(height: 16),
              _buildInputField('CNIC', cnicController),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Implement the logic to save the complaint
                  submitComplaint(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Submit Complaint',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.indigo),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.indigo),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildLargeInputField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.indigo),
      maxLines: 5,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.indigo),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Future<void> submitComplaint(BuildContext context) async {
    final String subject = subjectController.text.trim();
    final String message = messageController.text.trim();
    final String name = nameController.text.trim();
    final String fatherName = fatherNameController.text.trim();
    final String cnic = cnicController.text.trim();

    // Get the current date and time
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('HH:mm:ss').format(now);

    print(subject);
    print(message);
    print(name);
    print(fatherName);
    print(cnic);

    // Validate if subject, message, name, and cnic are not empty
    if (subject.isEmpty || message.isEmpty || name.isEmpty || cnic.isEmpty) {
      // Show an error message or handle the case where fields are empty
      return;
    }

    // Construct your API endpoint or URL
    final String apiUrl = 'http://192.168.100.9:3000/submit_complaint';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Subject': subject,
          'complainMsg': message,
          'Complain_time': formattedTime,
          'Complain_date': formattedDate,
          'Name': name,
          'FatherName': fatherName,
          'CNIC': cnic,
          'Stat':'pending',
        }),
      );

      if (response.statusCode == 201) {
        // Handle the success case
        print('Complaint submitted successfully');
      } else {
        print('Error submitting complaint. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that occurred during the HTTP request
      print('Error: $e');
    }

    // For now, let's navigate back to the dashboard
    Navigator.pop(context);
  }
}

void main() {
  runApp(MaterialApp(
    home: AddComplaintPage(),
  ));
}
