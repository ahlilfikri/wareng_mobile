import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PortalPemerintahPage extends StatefulWidget {
  @override
  _PortalPemerintahPageState createState() => _PortalPemerintahPageState();
}

class _PortalPemerintahPageState extends State<PortalPemerintahPage> {
  List<dynamic> _portalData = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPortalData();
  }

  Future<void> _fetchPortalData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://wareng-three.vercel.app/api/v1/informasi/portal/get-portal',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _portalData = data['data']['data'];
          _isLoading = false;
          _errorMessage = '';
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Sistem sibuk, coba lagi nanti.';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Sistem sibuk, coba lagi nanti.';
      });
      print('Error fetching portal data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portal Pemerintah', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF00917C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:
          _isLoading
              ? Center(
                child: CircularProgressIndicator(color: Color(0xFF00917C)),
              )
              : _errorMessage.isNotEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      'Sistem Sedang Sibuk',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
              : _portalData.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      'Tidak ada agenda yang ditemukan',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Coba ubah filter atau kata kunci pencarian',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: _portalData.length,
                itemBuilder: (context, index) {
                  final portal = _portalData[index];
                  final imageUrl =
                      (portal['img'] != null &&
                              portal['img'] is List &&
                              portal['img'].isNotEmpty)
                          ? 'https://wareng-three.vercel.app/images/portal/${portal['img'][0]}'
                          : '';

                  return PortalCard(
                    title: portal['title'] ?? 'Judul Tidak Tersedia',
                    subtitle: portal['isi'] ?? 'Deskripsi Tidak Tersedia',
                    imageUrl: imageUrl,
                    url: portal['content'] ?? '',
                  );
                },
              ),
    );
  }
}

class PortalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String url;

  PortalCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.url,
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
            Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 80, color: Colors.grey);
              },
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Ensure the URL has a scheme (http or https)
                String launchUrlData = url;
                if (!launchUrlData.startsWith('http://') && !launchUrlData.startsWith('https://')) {
                  launchUrlData = 'https://' + launchUrlData;
                }

                final uri = Uri.parse(launchUrlData);
                  await launchUrl(uri);
              },
              child: Text('Kunjungi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00917C),
                foregroundColor: Colors.white,
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
