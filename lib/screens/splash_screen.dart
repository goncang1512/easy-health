import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _textController;

  bool auth = true;

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _textController.forward();

    // delay → navigasi ke login

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return; // supaya aman dari use_build_context_synchronously

      if (auth) {
        context.go("/", extra: "fromSplash"); // ke Home (MainScreen)
      } else {
        context.go("/login", extra: "fromSplash"); // ke LoginScreen
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // background putih
      body: Stack(
        children: [
          // Background dekorasi lingkaran hijau transparan
          Positioned(
            top: 80,
            right: 40,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.green.withValues(alpha: 0.1),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 30,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green.withValues(alpha: 0.1),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -20,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: Colors.green.withValues(alpha: 0.15),
            ),
          ),
          // Konten utama
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo aplikasi (bisa ganti dengan Image.asset jika punya logo file PNG/SVG)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981), // hijau seperti gambar
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    "images/stetoscope.png",
                    width: 60,
                    height: 60,
                    color: Colors.white, // kalau mau icon jadi putih
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Easy Health",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Booking Dokter Lebih Mudah",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          // versi aplikasi di bawah
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "v1.2",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
