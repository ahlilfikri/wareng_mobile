import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'informasi_desa_page.dart';
import 'agenda_page.dart';
import 'portal_pemerintah_page.dart';
import 'portal_pemerintah_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/landing/bg-landing-page.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Color(0xFF052F2A).withOpacity(0.7),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Portal Terintegrasi Sistem Informasi,\nAdministrasi dan Pelayanan Desa Wareng',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
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
                  SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {
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
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await launch('https://www.instagram.com/desawareng/');
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await launch('https://www.google.com/maps/place/Wareng,+Wonosari,+Gunungkidul+Regency,+Special+Region+of+Yogyakarta/@-7.9923891,110.5601612,15z/data=!3m1!4b1!4m6!3m5!1s0x2e7bb3aabce9199b:0xc7c716c3b640497f!8m2!3d-7.9890045!4d110.5721975!16s%2Fg%2F122_sfwv?entry=ttu&g_ep=EgoyMDI1MDUyMS4wIKXMDSoASAFQAw%3D%3D');
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await launch('https://www.facebook.com/masyarakatdesawareng/');
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
