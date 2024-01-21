import 'package:flutter/material.dart';

class EditComplaintPage extends StatefulWidget {
  @override
  _EditComplaintPageState createState() => _EditComplaintPageState();
}

class _EditComplaintPageState extends State<EditComplaintPage> {
  // Sample texts for the dropdown menu
  List<String> dropdownItems = ['Category 1', 'Category 2', 'Category 3', 'Category 4', 'Category 5'];

  // Random initial text for the complaint
  String initialComplaintText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

  // Controller for the complaint text field
  TextEditingController _complaintTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _complaintTextController.text = initialComplaintText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Complaint',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Center(
              child: Text(
                'Edit Complaint Section',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
            ),
            SizedBox(height: 24),
            _buildDropdownMenu(),
            SizedBox(height: 16),
            _buildComplaintTextField(),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to submit changes
                // For now, let's print the changes to the console
                print('Category: ${dropdownItems.first} | Complaint Text: ${_complaintTextController.text}');
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
                'Submit Changes',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownMenu() {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownItems.first,
      onChanged: (String? newValue) {
        setState(() {
          // Implement logic to handle dropdown value changes
        });
      },
      items: dropdownItems.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildComplaintTextField() {
    return TextField(
      controller: _complaintTextController,
      style: TextStyle(color: Colors.indigo),
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Complaint Text',
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
}

void main() {
  runApp(MaterialApp(
    home: EditComplaintPage(),
  ));
}
