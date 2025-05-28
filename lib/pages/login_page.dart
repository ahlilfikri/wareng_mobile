import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'landing_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nikController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variable to track the loading state
  bool isLoading = false;

  // Fungsi untuk melakukan login
  Future<void> login() async {
    setState(() {
      isLoading = true; // Set loading to true when login starts
    });

    final String url = 'https://wareng-three.vercel.app/api/v1/administrasi/warga/login';

    try {
      // Mencetak data yang akan dikirim ke server
      if (nikController.text.isEmpty || passwordController.text.isEmpty) {
        setState(() {
          isLoading = false; // Set loading to false when there's an error
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Gagal'),
            content: Text('NIK atau Password tidak boleh kosong.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      print('Mempersiapkan request ke API...');
      print('NIK: ${nikController.text}');
      print('Password: ${passwordController.text}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': nikController.text,
          'password': passwordController.text,
        }),
      );

      // Log respons dari server
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      setState(() {
        isLoading = false; // Set loading to false when response is received
      });

      if (response.statusCode == 200) {
        // Login berhasil, arahkan ke LandingPage
        print('Login berhasil!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      } else {
        // Jika login gagal, tampilkan pesan error
        print('Login gagal, status code: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Gagal'),
            content: Text('NIK atau Password yang Anda masukkan salah.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Menangani error jika terjadi masalah dengan koneksi atau API
      setState(() {
        isLoading = false; // Set loading to false in case of error
      });
      print('Terjadi error: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Terjadi Kesalahan'),
          content: Text('Tidak dapat terhubung ke server.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/logo-wareng-full.png', height: 40),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: nikController,
              decoration: InputDecoration(
                labelText: 'NIK',
                hintText: 'Masukkan NIK / username',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF00917C)),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Masukkan Password Anda',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF00917C)),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : login, // Disable button when loading
                  child: isLoading
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    'MASUK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    backgroundColor: Color(0xFF00917C),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
