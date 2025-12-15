import 'package:easyhealth/screens/chat_screen.dart';
import 'package:easyhealth/utils/theme.dart';
import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import 'package:provider/provider.dart';
import '../provider/message_provider.dart';
import '../utils/fetch.dart';


class DetailBookingPage extends StatelessWidget {
  final BookingModel booking;

  // 👇 Tambahkan ini!
  final VoidCallback onDelete;

  const DetailBookingPage({
    super.key,
    required this.booking,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.secondary,
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ThemeColors.secondary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detail Booking",
          style: TextStyle(color: ThemeColors.secondary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeColors.secondary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Booking ID + Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booking ID : ${booking.bookingId}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      color: ThemeColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      booking.status,
                      style: const TextStyle(color: ThemeColors.secondary, fontSize: 12),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 16),

              /// Dokter
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      booking.doctorImage,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.doctorName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        booking.doctorSpecialist,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(booking.hospital),
              Text(booking.date),
              Text(booking.time),

              const SizedBox(height: 16),

              /// Intruksi Khusus
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info, color: ThemeColors.primary, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Harap datang 15 menit lebih awal dari waktu perjanjian",
                        style: TextStyle(
                            color: ThemeColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Info tambahan
              Text("No. Antrian : ${booking.queueNumber}"),
              Text("Biaya Konsultasi : Rp.${booking.price}"),
              Text("Metode Pembayaran : ${booking.paymentMethod}"),

              const SizedBox(height: 20),

              /// Hubungi RS
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.primary),
                  onPressed: () async {
                    final messageProvider = context.read<MessageProvider>();
                    final senderId = messageProvider.session!.user.id;
                    final hospitalId = booking.hospitalId;
                    if (hospitalId == null) return;
                    
                    // 1️⃣ Buat / ambil room RS
                    final room = await messageProvider.createRoom(senderId, hospitalId);
                    if (room['status'] == true) {
                      final roomId = room['roomId'];
                      // 2️⃣ Ambil chat RS tersebut
                      await messageProvider.fetchChat(roomId);
                      
                      // 3️⃣ Masuk ke ChatScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreenMessage(
                            roomId: roomId, // backend roomId
                          ),
                        ),
                      );
                    }
},

                  child: const Text("Hubungi Rumah Sakit"),
                ),
              ),

              const SizedBox(height: 10),

/// Cancel button
SizedBox(
  width: double.infinity,
  child: OutlinedButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.red,
      side: const BorderSide(color: Colors.red),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () async {
      try {
        // 1️⃣ Panggil API cancel booking dengan HTTP.delete
        final result = await HTTP.delete("/api/booking/cancel/${booking.id}",);

        // 2️⃣ Cek apakah response sukses
        if (result is Map<String, dynamic> && result['status'] == true) {
          // Callback untuk update list booking
          onDelete();

          // Tutup detail page
          Navigator.pop(context);

          // Optional: tampilkan pesan sukses
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Booking berhasil dibatalkan")),
          );
        } else {
          // Jika gagal, tampilkan pesan error dari backend
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(result['message'] ?? "Gagal membatalkan booking")),
          );
        }
      } catch (e) {
        // Tangani error network / json decode
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal membatalkan booking: $e")),
        );
      }
    },
    child: const Text(
      "Canceled",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
),


            ],
          ),
        ),
      ),
    );
  }
}