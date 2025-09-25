import 'package:flutter/material.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({super.key});

  @override
  State<NotifScreen> createState() => _NotifPage();
}

class _NotifPage extends State<NotifScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Notifikasi Page")));
  }
}
