import 'package:flutter/material.dart';
import 'pages/login_page.dart'; // Import the LoginPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inside Wareng',
      home: LoginPage(), // Only call LoginPage here
    );
  }
}
