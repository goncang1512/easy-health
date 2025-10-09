import 'package:easyhealth/models/docter_model.dart';
import 'package:easyhealth/widgets/booking_docter/create_booking.dart';
import 'package:easyhealth/widgets/booking_docter/docter_profile.dart';
import 'package:easyhealth/widgets/booking_docter/form_booking.dart';
import 'package:easyhealth/provider/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DocterScreen extends StatefulWidget {
  final String docterId;
  const DocterScreen({super.key, required this.docterId});

  @override
  State<DocterScreen> createState() => _DocterPage();
}

class _DocterPage extends State<DocterScreen> {
  late Future<DocterModel?> futureDocter;

  @override
  void initState() {
    super.initState();
    final provider = context.read<BookingProvider>();
    futureDocter = provider.getDetailDocter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? IconButton(
                onPressed: () => context.pop(),
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
      body: FutureBuilder<DocterModel?>(
        future: futureDocter,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Tidak ada data"));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                DocterProfile(docter: snapshot.data),
                FormBooking(),
                CreateBooking(
                  docterId: snapshot.data?.id ?? "",
                  hospitalId: snapshot.data?.hospital?.id ?? "",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
