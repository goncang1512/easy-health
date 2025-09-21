import 'package:easyhealth/components/main_screen.dart';
import 'package:easyhealth/pages/login_screen.dart';
import 'package:flutter/material.dart';

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
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => auth ? MainScreen() : LoginScreen(),
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
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
      // Hapus backgroundColor dari Scaffold
      body: Container(
        // Gunakan Container untuk latar belakang gradien
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 222, 229, 233),
              Color.fromARGB(255, 232, 241, 245),
              Color.fromARGB(255, 193, 207, 213),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Splash Screen", style: TextStyle(fontSize: 50)),
              // Hero(
              //   tag: "app_logo",
              //   // child: Image.asset(
              //   //   "assets/images/logo-android.png",

              //   //   width: 400,

              //   //   height: 400,
              //   // ),
              // ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
