import 'package:easyhealth/widgets/auth_screen/form_login.dart';
import 'package:easyhealth/widgets/auth_screen/top_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPages();
}

class _LoginPages extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopAuth(),
            const SizedBox(height: 70),
            TitlePage(),
            const SizedBox(height: 40),
            Center(child: FormLogin()),
          ],
        ),
      ),
    );
  }
}

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
        ),

        Text("Masuk ke akun anda", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
