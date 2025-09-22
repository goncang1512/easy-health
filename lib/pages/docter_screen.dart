import 'package:easyhealth/components/booking_docter/create_booking.dart';
import 'package:easyhealth/components/booking_docter/docter_profile.dart';
import 'package:easyhealth/components/booking_docter/form_booking.dart';
import 'package:easyhealth/provider/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocterScreen extends StatefulWidget {
  final String docterId;
  const DocterScreen({super.key, required this.docterId});

  @override
  State<DocterScreen> createState() => _DocterPage();
}

class _DocterPage extends State<DocterScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BookingProvider())],
      child: Scaffold(
        appBar: AppBar(
          leading: Navigator.canPop(context)
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                )
              : null,
          title: Text(
            "Booking Dokter",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFF10B981),
          foregroundColor: Colors.white, // biar icon/teks jadi hitam
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [DocterProfile(), FormBooking(), CreateBooking()],
          ),
        ),
      ),
    );
  }
}
