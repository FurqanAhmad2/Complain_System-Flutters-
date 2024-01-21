import 'package:flutter/material.dart';

class RemoveComplaintPage extends StatefulWidget {
  @override
  _RemoveComplaintPageState createState() => _RemoveComplaintPageState();
}

class _RemoveComplaintPageState extends State<RemoveComplaintPage> {
  // Sample texts for the dropdown menu
  List<String> dropdownItems = ['Complaint 1', 'Complaint 2', 'Complaint 3', 'Complaint 4', 'Complaint 5'];

  // Selected item from the dropdown
  String selectedItem = 'Complaint 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Remove Complaint',
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
                'Remove Complaint Section',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
            ),
            SizedBox(height: 24),
            _buildDropdownMenu(),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to remove the selected complaint
                // For now, let's print the removed complaint to the console
                print('Removed Complaint: $selectedItem');
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
                'Remove Complaint',
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
      value: selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          selectedItem = newValue!;
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
}

void main() {
  runApp(MaterialApp(
    home: RemoveComplaintPage(),
  ));
}
