import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For social media icons

// SocialMediaButtons Class (to handle the launching of URLs)
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Instagram Button
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.instagram,
            color: Colors.white,
          ),
          onPressed: () {
            _launchURL(
              'https://www.instagram.com/your_profile',
              appScheme: 'instagram://user?username=your_profile',
            );
          },
        ),

        // Google Search Button
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
          onPressed: () {
            _launchURL(
              'https://www.google.com',
              appScheme: 'googlechrome://navigate?url=https://www.google.com',
            );
          },
        ),

        // Facebook Button
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.facebook,
            color: Colors.white,
          ),
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

// Main InformasiDesaPage Class
class InformasiDesaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Desa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF00917C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tentang Wareng Section with Background and Overlay
              Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: Image.asset(
                        'assets/informasi/bg-landing-page.png', // Replace with your actual image path
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Green overlay with opacity
                    Positioned.fill(
                      child: Container(
                        color: Color(0xFF052F2A).withOpacity(0.6), // Green with opacity
                      ),
                    ),
                    // Content of the Tentang Wareng section
                    Positioned(
                      top: 50, // Adjust to position the content
                      left: 16,
                      right: 16,
                      bottom: 50,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Keep the container background transparent
                        ),
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
                              'Kalurahan Wareng, Wonosari, Gunungkidul adalah salah satu kalurahan yang berada di kecamatan Wonosari, Kabupaten Gunungkidul, Daerah Istimewa Yogyakarta, Indonesia. Kalurahan ini memiliki kekayaan budaya dan alam yang khas, terutama karena letaknya di kawasan Gunungkidul yang dikenal dengan keindahan alam karstnya. Desa ini memiliki batas-batas administratif yang jelas. Di sebelah utara, Desa Wareng berbatasan dengan Desa Pampang dan Desa Sodo. Sebelah timur, desa ini berbatasan dengan Desa Siraman. Di sebelah barat, berbatasan dengan Desa Mulo. Sedangkan di sebelah selatan, Desa Wareng berbatasan dengan Desa Karangrejek. Dengan lokasi yang strategis ini, Desa Wareng menjadi salah satu desa yang berperan penting dalam perkembangan wilayah Wonosari, Gunungkidul.',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 20),
                            // Social Media Buttons (After Description)
                            SocialMediaButtons(),  // Added Social Media Buttons below the description
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              // Sambutan Lurah Section
              SambutanLurahSection(),
              SizedBox(height: 40),
              // Visi & Misi Section
              Container(
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
              ),
              SizedBox(height: 40),
              // Kegiatan Desa Section
              Text(
                'Kegiatan Desa',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Carousel Slider with Activity Cards
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  viewportFraction: 0.8,
                ),
                items: List.generate(4, (index) {
                  return ActivityCard(
                    title: 'Lomba Pengagungan Antar Kalurahan Se-Kapanewon Wonosari',
                    date: '11/08/2024',
                    location: 'Balai Kalurahan Wareng Dan Padukuhan Singkar II',
                    imageUrl: 'assets/informasi/activity-image.png', // Replace with actual image path
                  );
                }),
              ),
              SizedBox(height: 20),
              // Perangkat Desa Section
              Text(
                'Perangkat Desa',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Perangkat Desa Members
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [PerangkatDesaCard(), PerangkatDesaCard()],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
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
        border: Border(
          bottom: BorderSide(
            color: Colors.white, // Border color
            width: 2, // Border width
          ),
        ),
      ),
      child: Column(
        children: [
          // Avatar Image (as a regular rectangular image)
          Image.asset(
            'assets/informasi/image-pak-lurah.png',  // Replace with actual image path
            height: 250,  // Adjust height as per your requirement
            width: 150,   // Adjust width if needed
            fit: BoxFit.cover,  // Use BoxFit.cover to make sure image fits nicely
          ),
          SizedBox(height: 20), // Add space between the image and the text

          // Title: Sambutan Lurah Wareng
          Text(
            'Sambutan Lurah Wareng',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Text color
            ),
          ),
          SizedBox(height: 8), // Space between the title and the name

          // Name: Ari Wibawa, S.I.P.
          Text(
            'Ari Wibawa, S.I.P.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black, // Text color
            ),
          ),
          SizedBox(height: 16), // Space between the name and description

          // Description text (Greeting message)
          Text(
            'Assalamualaikum warahmatullahi wabarakatuh.\n'
                'Selamat datang di website resmi Sistem Informasi Desa (SID) Kalurahan Wareng. '
                'Saya Ari Wibawa, Lurah Wareng, mengucapkan selamat datang yang sebesar-besarnya kepada seluruh warga masyarakat Desa Wareng dan para pengunjung website ini. '
                'Melalui website ini, kami berupaya untuk memberikan informasi yang akurat, terkini, dan transparan mengenai segala aspek kehidupan di Desa Wareng. Mulai dari informasi pemerintahan, pembangunan, pelayanan publik, hingga potensi dan kekayaan alam yang kita miliki. Semoga website ini dapat menjadi jembatan komunikasi yang efektif antar pemerintah dan masyarakat Desa Wareng. Mari kita bersama-sama membangun Desa Wareng yang lebih maju, sejahtera, dan bermartabat. '
                'Wassalamualaikum warahmatullahi wabarakatuh.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black, // Text color
            ),
            textAlign: TextAlign.justify,  // Justify the description text
          ),
        ],
      ),
    );
  }
}


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
            Text(
              date,
              style: TextStyle(fontSize: 14),
            ),
            Text(
              location,
              style: TextStyle(fontSize: 14),
            ),
            TextButton(
              onPressed: () {
                // Action when "Baca lebih banyak >>" is pressed
              },
              child: Text('Baca lebih banyak >>'),
            ),
          ],
        ),
      ),
    );
  }
}

class PerangkatDesaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(
                'assets/informasi/image-pak-lurah.png',
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Perangkat Desa',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Jabatan Perangkat Desa'),
            TextButton(onPressed: () {}, child: Text('Hubungi Perangkat')),
          ],
        ),
      ),
    );
  }
}
