// import 'package:easyhealth/utils/social_auth.dart';
import 'package:flutter/material.dart';

class AutheSocial extends StatelessWidget {
  const AutheSocial({super.key});

  @override
  Widget build(BuildContext context) {
    // final social = SocialSign();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey, // warna garis
                thickness: 1, // ketebalan garis
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("atau", style: TextStyle(color: Colors.grey)),
            ),
            Expanded(child: Divider(color: Colors.grey, thickness: 1)),
          ],
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity, // biar full lebar
          child: ElevatedButton(
            onPressed: () async {
              // final data = await social.loginGetIdToken();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ), // cukup vertical saja
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  // bordernya
                  color: Color.fromARGB(255, 199, 199, 199), // warna border
                  width: 1, // ketebalan border
                ),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://i.pinimg.com/1200x/c8/b8/12/c8b8129127bada9fa699aeba388b3b2b.jpg", // masukkan logo Google di folder assets
                  height: 24,
                ),
                const SizedBox(width: 10),
                const Text(
                  "Login dengan Google",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
