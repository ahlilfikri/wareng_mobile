import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tubes/pages/detail_agenda_page.dart';

class SocialMediaButtons extends StatelessWidget {
  Future<void> _launchURL(String urlString, {String? appScheme}) async {
    final Uri uriScheme = Uri.parse(appScheme ?? urlString);
    final Uri uriFallback = Uri.parse(urlString);
    if (appScheme != null && await canLaunchUrl(uriScheme)) {
      await launchUrl(uriScheme, mode: LaunchMode.externalApplication);
      return;
    }
    if (await canLaunchUrl(uriFallback)) {
      await launchUrl(uriFallback, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
          onPressed: () {
            _launchURL(
              'https://www.instagram.com/your_profile',
              appScheme: 'instagram://user?username=your_profile',
            );
          },
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
          onPressed: () {
            _launchURL(
              'https://www.google.com',
              appScheme: 'googlechrome://navigate?url=https://www.google.com',
            );
          },
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
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

class TentangWarengSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/informasi/bg-landing-page.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Color(0xFF052F2A).withOpacity(0.6)),
          ),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            bottom: 50,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.transparent),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tentang Wareng',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Desa Wareng terletak di Kecamatan Wonosari, Kabupaten Gunungkidul, Yogyakarta. Desa ini memiliki batas-batas administratif yang jelas. Di sebelah utara, Desa Wareng berbatasan dengan Desa Pampang dan Desa Sodo. Sebelah timur, desa ini berbatasan dengan Desa Siraman. Di sebelah barat, berbatasan dengan Desa Mulo. Sedangkan di sebelah selatan, Desa Wareng berbatasan dengan Desa Karangrejek. Dengan lokasi yang strategis ini, Desa Wareng menjadi salah satu desa yang berperan penting dalam perkembangan wilayah Wonosari, Gunungkidul.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  SocialMediaButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SambutanLurahSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border(bottom: BorderSide(color: Colors.white, width: 2)),
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/informasi/image-pak-lurah.png',
            height: 250,
            width: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            'Sambutan Lurah Wareng',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Ari Wibawa, S.I.P.',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            child: Text(
              'Assalamualaikum warahmatullahi wabarakatuh. Selamat datang di website resmi Sistem Informasi Desa (SID) Kalurahan Wareng. '
              'Saya Ari Wibawa, Lurah Wareng, mengucapkan selamat datang yang sebesar-besarnya kepada seluruh warga masyarakat Desa Wareng dan para pengunjung website ini. '
              'Melalui website ini, kami berupaya untuk memberikan informasi yang akurat, terkini, dan transparan mengenai segala aspek kehidupan di Desa Wareng. '
              'Mulai dari informasi pemerintahan, pembangunan, pelayanan publik, hingga potensi dan kekayaan alam yang kita miliki. '
              'Semoga website ini dapat menjadi jembatan komunikasi yang efektif antara pemerintah desa dengan masyarakat. '
              'Mari kita bersama-sama membangun Desa Wareng yang lebih maju, sejahtera, dan bermartabat. '
              'Wassalamualaikum warahmatullahi wabarakatuh.',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

class VisiMisiSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.only(
          left: 25.0,
          top: 50.0,
          right: 25.0,
          bottom: 50.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF00917C),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'VISI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Terwujudnya Masyarakat Kalurahan Wareng yang religius, maju, berdaya saing, mandiri, dan sejahtera.',
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'MISI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Mewujudkan kehidupan masyarakat yang lebih baik dengan mengedepankan kerja sama, gotong royong, toleransi dan Agamis',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  '2. Meningkatkan pelayanan Publik dan keterbukaan informasi berbasis teknologi.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  '3. Membangun SUMBER DAYA dengan memadukan potensi lokal di sektor Kebudayaan, Pariwisata, Pertanian, perikanan, peternakan dan Perdagangan.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KegiatanDesaSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 35.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'Kegiatan Desa',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 20),
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.4,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            viewportFraction: 0.8,
          ),
          items: List.generate(4, (index) {
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: 150),
              child: ActivityCard(
                title:
                    'Lomba Pengagungan Antar Kalurahan Se-Kapanewon Wonosari',
                date: '11/08/2024',
                location: 'Balai Kalurahan Wareng Dan Padukuhan Singkar II',
                imageUrl: 'assets/informasi/activity-example.png',
              ),
            );
          }),
        ),
      ],
    );
  }
}

class PerangkatDesaSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 35.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'Perangkat Desa',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 20),
        PerangkatDesaCarousel(),
        SizedBox(height: 40),
      ],
    );
  }
}

class InformasiDesaPage extends StatelessWidget {
  const InformasiDesaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Desa', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF00917C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TentangWarengSection(),
              SizedBox(height: 40),
              SambutanLurahSection(),
              SizedBox(height: 40),
              VisiMisiSection(),
              SizedBox(height: 40),
              KegiatanDesaSection(),
              SizedBox(height: 20),
              PerangkatDesaSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// Update the ActivityCard to navigate to DetailAgendaPage
class ActivityCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String imageUrl;

  ActivityCard({
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(imageUrl, height: 120, fit: BoxFit.cover),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(date, style: TextStyle(fontSize: 14)),
            Text(location, style: TextStyle(fontSize: 14)),
            TextButton(
              onPressed: () {
                // Navigate to DetailAgendaPage and pass the data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailAgendaPage(
                      title: title,
                      date: date,
                      location: location,
                      imageUrl: imageUrl,
                    ),
                  ),
                );
              },
              child: Text('Baca lebih banyak >>'),
            ),
          ],
        ),
      ),
    );
  }
}
class PerangkatDesaCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.3,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        viewportFraction: 0.8,
      ),
      items: [
        PerangkatDesaCard(
          name: 'Ari Wibawa, S.I.P.',
          position: 'Lurah Wareng',
          imageUrl: 'assets/informasi/image-pak-lurah.png',
        ),
        PerangkatDesaCard(
          name: 'Budi Santoso, S.T.',
          position: 'Sekretaris Desa',
          imageUrl: 'assets/informasi/image-pak-lurah.png',
        ),
        PerangkatDesaCard(
          name: 'Siti Aminah, S.Pd.',
          position: 'Kepala Urusan Pemerintahan',
          imageUrl: 'assets/informasi/image-pak-lurah.png',
        ),
        PerangkatDesaCard(
          name: 'Mulyani, S.E.',
          position: 'Kepala Urusan Pembangunan',
          imageUrl: 'assets/informasi/image-pak-lurah.png',
        ),
      ],
    );
  }
}

class PerangkatDesaCard extends StatelessWidget {
  final String name;
  final String position;
  final String imageUrl;

  PerangkatDesaCard({
    required this.name,
    required this.position,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(radius: 40, backgroundImage: AssetImage(imageUrl)),
            SizedBox(height: 8),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(position),
            TextButton(onPressed: () {}, child: Text('Hubungi Perangkat')),
          ],
        ),
      ),
    );
  }
}
