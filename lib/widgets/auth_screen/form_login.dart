// import 'package:easyhealth/widgets/auth_screen/auth_provider.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:easyhealth/provider/auth_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/secure_storage.dart';
import 'package:easyhealth/widgets/auth_screen/textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLogin();
}

class _FormLogin extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    void onLogin() async {
      if (!_formKey.currentState!.validate()) return;

      final response = await provider.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!context.mounted) return;
      final messenger = ScaffoldMessenger.of(context);

      if (response?["status"]) {
        await PrefsService.saveToken(response?["result"]["token"]);
        await context.read<SessionManager>().loadSession();
        messenger.hideCurrentMaterialBanner();
        context.go("/");
      }

      if (response?["status"] == false) {
        messenger.showMaterialBanner(
          MaterialBanner(
            backgroundColor: Colors.red.shade100,
            content: Text("Registering ${response?["message"]}"),
            actions: [
              TextButton(
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: const Text('Tutup'),
              ),
            ],
          ),
        );
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldLogin(
              controller: _emailController,
              label: "Email",
              placeholder: "Masukkan email",
              icon: Icons.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFieldLogin(
              controller: _passwordController,
              label: "Password",
              placeholder: "*******",
              icon: Icons.lock,
              type: "password",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity, // biar full lebar
              child: ElevatedButton(
                onPressed: provider.isLoading ? null : onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ), // cukup vertical saja
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // AutheSocial(),

            // const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun?", style: TextStyle(fontSize: 16)),

                const SizedBox(width: 5),

                GestureDetector(
                  onTap: () {
                    context.push("/register");
                  },
                  child: Text(
                    "Daftar",
                    style: TextStyle(color: Colors.green, fontSize: 16),
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
