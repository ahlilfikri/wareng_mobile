// lib/detail_agenda_page.dart
import 'package:flutter/material.dart';

class DetailAgendaPage extends StatelessWidget {
  final String? title;
  final String? date;
  final String? location;
  final String? imageUrl;

  // Constructor with optional parameters to accept data from ActivityCard
  const DetailAgendaPage({
    Key? key,
    this.title,
    this.date,
    this.location,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kegiatan',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor: Color(0xFF00917C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image if available
              if (imageUrl != null)
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(imageUrl!, fit: BoxFit.cover),
                ),
              SizedBox(height: 20),

              // Event title
              Text(
                title ?? 'Nama Kegiatan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00917C),
                ),
              ),
              SizedBox(height: 16),

              // Event details card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      Icons.calendar_today,
                      'Tanggal',
                      date ?? '24 September 2023',
                    ),
                    SizedBox(height: 10),
                    _buildDetailRow(
                      Icons.access_time,
                      'Waktu',
                      '09:00 - 12:00 WIB',
                    ),
                    SizedBox(height: 10),
                    _buildDetailRow(
                      Icons.location_on,
                      'Lokasi',
                      location ?? 'Balai Desa Wareng',
                    ),
                    SizedBox(height: 10),
                    _buildDetailRow(
                      Icons.person,
                      'Penyelenggara',
                      'Pemerintah Desa Wareng',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Description section
              Text(
                'Deskripsi Kegiatan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00917C),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Kegiatan ini merupakan bagian dari program pemberdayaan masyarakat desa yang bertujuan untuk meningkatkan kesejahteraan dan kapasitas warga desa. Acara ini akan dihadiri oleh pejabat desa, tokoh masyarakat, dan warga desa. Program ini mencakup berbagai aktivitas seperti pelatihan keterampilan, diskusi tentang potensi desa, dan rencana pengembangan infrastruktur desa.\n\nSeluruh warga desa diundang untuk berpartisipasi dan memberikan masukan demi kemajuan Desa Wareng. Acara ini juga akan menjadi kesempatan bagi warga untuk berinteraksi langsung dengan pejabat desa terkait aspirasi dan kebutuhan masyarakat.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),

              // Contact or registration section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF00917C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF00917C)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Kontak',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00917C),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Untuk informasi lebih lanjut, silakan hubungi:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Sekretariat Desa Wareng',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Telp: 0812-3456-7890',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Email: info@desawareng.desa.id',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Register button
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create detail rows with icons
  // Updated _buildDetailRow method with proper text wrapping
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Color(0xFF00917C), size: 20),
        SizedBox(width: 8),
        Expanded(
          // This ensures the column takes available width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                softWrap: true, // Ensures text wrapping
                overflow: TextOverflow.visible, // Shows all text
              ),
            ],
          ),
        ),
      ],
    );
  }
}
