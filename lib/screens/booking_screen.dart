import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingPage();
}

class _BookingPage extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Booking Page")));
  }
}
