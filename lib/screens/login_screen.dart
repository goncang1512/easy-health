import 'package:easyhealth/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:easyhealth/widgets/button.dart';
import 'package:easyhealth/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPages();
}

class _LoginPages extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Login Screen", style: TextStyle(fontSize: 50)),
            CustomButton(
              text: "Login",
              onPressed: () => {NavigationHelper.push(context, HomeScreen())},
            ),
          ],
        ),
      ),
    );
  }
}
