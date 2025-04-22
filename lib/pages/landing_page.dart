import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import the package

// Dummy pages to simulate navigation (you should replace these with actual pages)
import 'informasi_desa_page.dart';  // Example page for Informasi Desa
import 'agenda_page.dart';   // Example page for Kegiatan Desa
import 'portal_pemerintah_page.dart';          // Example page for Portal
import 'portal_pemerintah_page.dart';        // Example page for Aspirasi

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/landing/bg-landing-page.png',
              fit: BoxFit.cover,
            ),
          ),
          // Green overlay with 70% opacity
          Positioned.fill(
            child: Container(
              color: Color(0xFF052F2A).withOpacity(0.7), // Apply green color with opacity
            ),
          ),
          // Content (Buttons and Text)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main Heading
                  Text(
                    'Portal Terintegrasi Sistem Informasi,\nAdministrasi dan Pelayanan Desa Wareng',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center, // Correct placement of textAlign
                  ),
                  SizedBox(height: 40), // Space between heading and buttons
                  // Buttons
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Informasi Desa
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InformasiDesaPage()),
                      );
                    },
                    child: Text(
                      'Informasi Desa',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                      backgroundColor: Color(0xFF00917C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(200, 50),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15), // Space between buttons

                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Kegiatan Desa
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AgendaPage()),
                      );
                    },
                    child: Text(
                      'Kegiatan Desa',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                      backgroundColor: Color(0xFF00917C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(200, 50),
                    ),
                  ),
                  SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Portal
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PortalPemerintahPage()),
                      );
                    },
                    child: Text(
                      'Portal',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                      backgroundColor: Color(0xFF00917C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(200, 50),
                    ),
                  ),
                  SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Aspirasi
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PortalPemerintahPage()),
                      );
                    },
                    child: Text(
                      'Aspirasi',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                      backgroundColor: Color(0xFF00917C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(200, 50),
                    ),
                  ),
                  SizedBox(height: 30), // Space for bottom icons
                  // Bottom Icons (Social Media)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Instagram onClick
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Google onClick
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Facebook onClick
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
