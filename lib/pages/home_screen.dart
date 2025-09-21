import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePage();
}

class _HomePage extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Home Page")));
  }
}
