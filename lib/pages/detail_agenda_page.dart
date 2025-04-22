// lib/detail_agenda_page.dart
import 'package:flutter/material.dart';

class DetailAgendaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nama Kegiatan'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Nama Kegiatan: Seminar Desa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Jam: 12:00 WIB'),
            SizedBox(height: 10),
            Text('Lokasi: Desa Lorem Kec.Ipsum'),
            SizedBox(height: 10),
            Text('Tanggal: 24 September 2023'),
            SizedBox(height: 20),
            Text(
              'Deskripsi kegiatan yang lebih panjang dan detail mengenai acara yang akan berlangsung...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
