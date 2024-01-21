import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckComplaintStatusPage extends StatefulWidget {
  @override
  _CheckComplaintStatusPageState createState() => _CheckComplaintStatusPageState();
}

class _CheckComplaintStatusPageState extends State<CheckComplaintStatusPage> {
  String selectedSubject = '';
  List<String> dropdownItems = [];
  TextEditingController cnicController = TextEditingController();
  String statusResponse = ''; // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Check Complaint Status',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Check Complaint Status',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
            ),
            SizedBox(height: 24),
            _buildInputField('CNIC', cnicController),
            SizedBox(height: 16),
            _buildStatusDropdown(),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await _fetchSubjects(cnicController.text.trim());
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
                'Fetch Complains',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await checkComplaintStatus();
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
                'Check Status',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: Text(
                statusResponse,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedSubject,
      onChanged: (value) {
        setState(() {
          selectedSubject = value!;
        });
      },
      items: dropdownItems.map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Text(status),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Choose Your Complain Subject',
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

  Future<void> _fetchSubjects(String cnic) async {
    final apiUrl = 'http://192.168.100.9:3000/getSubjects/$cnic';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          dropdownItems = List<String>.from(json.decode(response.body));
          selectedSubject = dropdownItems.isNotEmpty ? dropdownItems[0] : null!;
        });
      } else {
        print('Error fetching subjects. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> checkComplaintStatus() async {
    final String cnic = cnicController.text.trim();
    final String apiUrl = 'http://192.168.100.9:3000/checkComplaintStatus';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'CNIC': cnic,
          'Subject': selectedSubject,
        }),
      );

      if (response.statusCode == 200) {

        final responseBody = json.decode(response.body);
        setState(() {
          statusResponse = 'Complaint status: ${responseBody['Stat']}';
        });
        print('Response body: ${response.body}');


      } else {
        setState(() {
          statusResponse = 'Error checking complaint status. Status code: ${response.statusCode}';
        });
        print('Response body: ${response.body}');
      }
    } catch (e) {
      setState(() {
        statusResponse = 'Error: $e';
      });
      print('Error: $e');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckComplaintStatusPage(),
  ));
}
