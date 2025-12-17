import 'package:easyhealth/provider/message_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../models/booking_model.dart';
import '../widgets/booking_card.dart';
import '../utils/fetch.dart';
import 'package:provider/provider.dart';
import '../pages/detail_booking_page.dart';

class ListBookingScreen extends StatefulWidget {
  const ListBookingScreen({super.key});

  @override
  State<ListBookingScreen> createState() => _ListBookingScreenState();
}

class _ListBookingScreenState extends State<ListBookingScreen> {
  late Future<List<BookingModel>> bookingsFuture;

  @override
  void initState() {
    super.initState();
    bookingsFuture = fetchBookingFromApi();
  }

  Future<List<BookingModel>> fetchBookingFromApi() async {
    final session = context.read<SessionManager>();
    final response = await HTTP.get(
      "/api/booking/list/${session.session?.user.id}",
    );

    if (response['statusCode'] == 200) {
      List<dynamic> data = response['result'];
      // Filter booking yang statusnya bukan "canceled"
      List<BookingModel> bookings = data
          .map((json) => BookingModel.fromJson(json as Map<String, dynamic>))
          .where((b) => b.status.toLowerCase() != 'canceled') // ✅ filter
          .toList();

      return bookings;
    } else {
      return [];
    }
  }

  void deleteBooking(List<BookingModel> bookings, String id) {
    setState(() {
      bookings.removeWhere((b) => b.id == id); // 🔴 UBAH
    });
  }

  Future<void> refreshBookings() async {
    setState(() {
      bookingsFuture = fetchBookingFromApi();
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
        future: bookingsFuture,
        builder: (context, snapshot) {
          return RefreshIndicator(
            onRefresh: refreshBookings,
            child: () {
              // ================= LOADING =================
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 300),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              }

              // ================= ERROR =================
              if (snapshot.hasError) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 300),
                    Center(
                      child: Text(
                        "Terjadi kesalahan\nTarik ke bawah untuk refresh",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }

              // ================= DATA =================
              final bookings = List<BookingModel>.from(snapshot.data ?? []);

              // ================= EMPTY =================
              if (bookings.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: 300),
                    Center(
                      child: Text(
                        "Tidak ada booking\nTarik ke bawah untuk refresh",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              }

              // ================= LIST =================
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];

                  return BookingCard(
                    booking: booking,
                    onDelete: () {
                      deleteBooking(bookings, bookings[index].id);
                      refreshBookings();
                    },
                    // ---------- DETAIL ----------
                    onTap: () async {
                      final sessionManager = context.read<SessionManager>();

                      final deletedId = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => MessageProvider(
                              session: sessionManager.session,
                            ),
                            child: DetailBookingPage(
                              booking: booking,
                              onDelete: () {},
                            ),
                          ),
                        ),
                      );

                      if (!mounted) return;

                      if (deletedId != null) {
                        setState(() {
                          bookings.removeWhere((b) => b.id == deletedId);
                        });
                      }
                    },
                  );
                },
              );
            }(),
          );
        },
      ),
    );
  }
}
