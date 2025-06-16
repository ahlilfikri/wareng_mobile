import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(AspirasiApp());
}

class AspirasiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AspirasiForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AspirasiForm extends StatefulWidget {
  @override
  _AspirasiFormState createState() => _AspirasiFormState();
}

class _AspirasiFormState extends State<AspirasiForm> {
  final _aspirasiController = TextEditingController();
  String? _selectedKategori;

  final List<String> _kategoriList = [
    'Infrastruktur',
    'Pendidikan',
    'Kesehatan',
    'Kesejahteraan',
  ];

  // API endpoint for the backend
  final String apiUrl = "http://your-backend-api.com/api/aspirasi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Aspirasi Masyarakat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007F56),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Aspirasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _aspirasiController,
              decoration: InputDecoration(
                hintText: 'Masukkan Aspirasi Anda',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24),
            Text(
              'Kategori',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedKategori,
              hint: Text('Pilih Kategori'),
              items: _kategoriList.map((kategori) {
                return DropdownMenuItem(
                  value: kategori,
                  child: Text(kategori),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedKategori = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_aspirasiController.text.isNotEmpty && _selectedKategori != null) {
                    _submitAspirasi();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Pastikan semua field terisi')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007F56),
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text('Kirim'),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: Text(
                'Kami menjaga kerahasiaan aspirasi Anda\nuntuk tidak dibuka ke publik secara langsung',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to send data to backend
  Future<void> _submitAspirasi() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'aspirasi': _aspirasiController.text,
        'kategori': _selectedKategori,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Aspirasi berhasil dikirim')),
      );
      _aspirasiController.clear();
      setState(() {
        _selectedKategori = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim aspirasi')),
      );
    }
  }
}
