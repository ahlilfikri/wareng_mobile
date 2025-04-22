import 'package:flutter/material.dart';

class AgendaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agenda Desa',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor: Color(0xFF00917C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          AgendaItem(
            title: 'Nama Agenda',
            date: '24 September 2023',
            time: '12:00 WIB',
            imagePath:
                'assets/image-not-found.png', // Replace with your image path
          ),
          AgendaItem(
            title: 'Nama Agenda',
            date: '25 September 2023',
            time: '14:00 WIB',
            imagePath:
                'assets/image-not-found.png', // Replace with your image path
          ),
          AgendaItem(
            title: 'Nama Agenda',
            date: '25 September 2023',
            time: '14:00 WIB',
            imagePath:
                'assets/image-not-found.png', // Replace with your image path
          ),
          AgendaItem(
            title: 'Nama Agenda',
            date: '25 September 2023',
            time: '14:00 WIB',
            imagePath:
                'assets/image-not-found.png', // Replace with your image path
          ),
          AgendaItem(
            title: 'Nama Agenda',
            date: '25 September 2023',
            time: '14:00 WIB',
            imagePath:
                'assets/image-not-found.png', // Replace with your image path
          ),
          AgendaItem(
            title: 'Nama Agenda',
            date: '25 September 2023',
            time: '14:00 WIB',
            imagePath:
                'assets/image-not-found.png', // Replace with your image path
          ),
          AgendaItem(
            title: 'Nama Agenda',
            date: '25 September 2023',
            time: '14:00 WIB',
            imagePath:
                'assets/image-not-found.png', // Replace with your image path
          ),
        ],
      ),
    );
  }
}

class AgendaItem extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String imagePath;

  AgendaItem({
    required this.title,
    required this.date,
    required this.time,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Image on the left
            Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.cover),
            SizedBox(width: 16), // Space between image and text
            // Column with title, date, time, and button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Date and Time
                  Text(
                    '$date - $time',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  // Button
                  ElevatedButton(
                    onPressed: () {
                      // Your action here
                    },
                    child: Text('Kunjungi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00917C),
                      // Set the background color
                      foregroundColor: Colors.white, // Set text color to white
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
