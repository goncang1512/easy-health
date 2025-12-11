import 'package:easyhealth/provider/session_provider.dart';
import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../models/booking_model.dart';
import '../widgets/booking_card.dart';
import '../utils/fetch.dart'; // pastikan ada
import 'package:provider/provider.dart';

class ListBookingScreen extends StatefulWidget {
  const ListBookingScreen({super.key});

  @override
  State<ListBookingScreen> createState() => _ListBookingScreenState();
}

class _ListBookingScreenState extends State<ListBookingScreen> {
  // ==============================
  // 🔥 Ambil data dari API backend
  // ==============================
  Future<List<BookingModel>> fetchBookingFromApi() async {
      final session = context.read<SessionManager>();
      final response = await HTTP.get("/api/booking/list/${session.session?.user.id}");
      print("Response fetch booking: $response");
      if (response['statusCode'] == 200) {
        List<dynamic> data = response['result']; 
          return data.map((json) => BookingModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
  }

  // =======================
  // 🔥 Hapus booking lokal
  // =======================
  void deleteBooking(List<BookingModel> bookings, String id) {
    setState(() {
      bookings.removeWhere((b) => b.bookingId == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Booking"),
        backgroundColor: ThemeColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder<List<BookingModel>>(
        future: fetchBookingFromApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final bookings = snapshot.data ?? [];

            if (bookings.isEmpty) {
              return const Center(
                child: Text(
                  "Tidak ada booking",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return BookingCard(
                  booking: bookings[index],
                  onDelete: () => deleteBooking(bookings, bookings[index].bookingId),
                );
              },
            );
          }
        },
      ),
    );
  }
}
