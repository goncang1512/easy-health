// import 'package:easyhealth/widgets/auth_screen/auth_provider.dart';
import 'package:easyhealth/provider/auth_provider.dart';
import 'package:easyhealth/utils/alert.dart';
import 'package:easyhealth/widgets/auth_screen/textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegister();
}

class _FormRegister extends State<FormRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    void onLogin() async {
      if (!_formKey.currentState!.validate()) return;

      final response = await provider.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPassword.text,
      );

      if (!context.mounted) return;
      if (response?["status"]) {
        context.go("/login");
      }

      if (response?["status"] == false) {
        Alert.showBanner("Registering ${response?["message"]}", context);
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
              controller: _nameController,
              label: "Nama",
              placeholder: "Masukkan nama",
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            TextFieldLogin(
              controller: _confirmPassword,
              label: "Confirm Password",
              placeholder: "*******",
              icon: Icons.lock,
              type: "password",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your confirmation password";
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
                  "Daftar",
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
                Text("Sudah punya akun?", style: TextStyle(fontSize: 16)),

                const SizedBox(width: 5),

                GestureDetector(
                  onTap: () {
                    context.push("/login");
                  },
                  child: Text(
                    "Masuk",
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
