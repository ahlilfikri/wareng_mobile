import 'package:flutter/material.dart';

class PortalPemerintahPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Portal Pemerintah',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor: Color(0xFF00917C), // Set the background color here
        iconTheme: IconThemeData(
          color: Colors.white,
        ), // Set back button color to white
      ),
      body: ListView(
        children: [
          PortalCard(
            title: 'SINKAL',
            subtitle:
                'SINKAL merupakan program yang diadakan oleh Biro Tata Pemerintahan Setda DIY yang terintegrasi mulai...',
            image:
                'assets/informasi/activity-example.png', // Replace with actual image asset
          ),
          PortalCard(
            title: 'SID',
            subtitle:
                'Sistem Informasi Desa (SID) adalah sebuah platform teknologi informasi komunikasi untuk mendukung pe...',
            image:
                'assets/informasi/activity-example.png', // Replace with actual image asset
          ),
          // Add more PortalCards as needed
        ],
      ),
    );
  }
}

class PortalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  // Constructor to receive title, subtitle, and image
  PortalCard({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Image on the left side
            Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
            SizedBox(width: 16), // Space between image and text
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
                  // Subtitle (description)
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 2, // Limit to 2 lines for the description
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis for overflow
                  ),
                ],
              ),
            ),
            // Button at the right side
            ElevatedButton(
              onPressed: () {},
              child: Text('Kunjungi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00917C), // Button background color
                foregroundColor: Colors.white, // Text color (foreground)
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
