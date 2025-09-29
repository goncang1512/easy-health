import 'package:easyhealth/widgets/auth_screen/form_register.dart';
import 'package:easyhealth/widgets/auth_screen/top_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopAuth(),
            const SizedBox(height: 70),
            TitlePage(),
            const SizedBox(height: 20),
            Center(child: FormRegister()),
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
          "Registrasi",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
        ),

        Text("Daftar akun anda", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
