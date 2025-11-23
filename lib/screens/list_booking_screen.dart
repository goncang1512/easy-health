import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../models/booking_model.dart';
import '../widgets/booking_card.dart';

class ListBookingScreen extends StatefulWidget {
  const ListBookingScreen({super.key});

  @override
  State<ListBookingScreen> createState() => _ListBookingScreenState();
}

class _ListBookingScreenState extends State<ListBookingScreen> {
  // List booking harus ada di State agar bisa dihapus
  List<BookingModel> bookings = [
    BookingModel(
      bookingId: "BK-23041",
      status: "Confirmed",
      doctorName: "Dr. Ferdy Ariyansyah",
      doctorSpecialist: "Spesialis Jantung",
      doctorImage: "https://img.freepik.com/foto-gratis/potret-dokter-medis-muda-yang-percaya-diri-di-dinding-putih_1150-26696.jpg?semt=ais_hybrid&w=740&q=80",
      hospital: "RS USU - Jl. Dr. Mansyur",
      date: "29 Oktober 2025",
      time: "09:00 WIB",
      queueNumber: "A12",
      price: "120.000",
      paymentMethod: "Transfer Bank",
    ),
  ];

  // Fungsi hapus booking
  void deleteBooking(String id) {
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
      body: bookings.isEmpty
          ? const Center(
              child: Text(
                "Tidak ada booking",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return BookingCard(
                  booking: bookings[index],

                  // 👇 Tambahkan onDelete di sini
                  onDelete: () => deleteBooking(bookings[index].bookingId),
                );
              },
            ),
    );
  }
}
