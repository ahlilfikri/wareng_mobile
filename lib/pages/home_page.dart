import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Import your pages here
import 'landing_page.dart';
import 'agenda_page.dart';
import 'portal_pemerintah_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    LandingPage(),
    AgendaPage(),
    PortalPemerintahPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF00917C),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Kegiatan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Portal',
          ),
        ],
      ),
    );
  }
}

// SocialMediaButtons tetap dipisah jika dibutuhkan di halaman mana pun
class SocialMediaButtons extends StatelessWidget {
  // Method to launch URLs or apps
  Future<void> _launchURL(String urlString, {String? appScheme}) async {
    final Uri uriScheme = Uri.parse(appScheme ?? urlString);
    final Uri uriFallback = Uri.parse(urlString);

    // Try deep link/app scheme first
    if (appScheme != null && await canLaunchUrl(uriScheme)) {
      await launchUrl(uriScheme, mode: LaunchMode.externalApplication);
      return;
    }
    // Fallback to browser
    if (await canLaunchUrl(uriFallback)) {
      await launchUrl(uriFallback, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            _launchURL(
              'https://www.instagram.com/your_profile',
              appScheme: 'instagram://user?username=your_profile',
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _launchURL(
              'https://www.google.com',
              appScheme:
              'googlechrome://navigate?url=https://www.google.com',
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.facebook),
          onPressed: () {
            _launchURL(
              'https://www.facebook.com/your_page',
              appScheme: 'fb://page/your_page_id',
            );
          },
        ),
      ],
    );
  }
}