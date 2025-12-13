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
    final response = await HTTP.get("/api/booking/list/${session.session?.user.id}");
    
    if (response['statusCode'] == 200) {
      List<dynamic> data = response['result'];
      // Filter booking yang statusnya bukan "canceled"
      List<BookingModel> bookings = data.map((json) => BookingModel.fromJson(json as Map<String, dynamic>))
      .where((b) => b.status.toLowerCase() != 'canceled') // ✅ filter
      .toList();
      
      return bookings;
      } else {
        return [];
        }
  }


  void deleteBooking(List<BookingModel> bookings, String id) {
    setState(() {
      bookings.removeWhere((b) => b.bookingId == id);
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final bookings = snapshot.data ?? [];

          if (bookings.isEmpty) {
            return const Center(
              child: Text(
                "Tidak ada booking",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: refreshBookings,
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return BookingCard(
                  booking: bookings[index],
                  onDelete: () {
                    deleteBooking(bookings, bookings[index].bookingId);
                    refreshBookings();
                  },
                  onTap: () async {
                    final deletedId = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailBookingPage(
                          booking: bookings[index],
                          onDelete: () {},
                        ),
                      ),
                  );
                    if (deletedId != null && deletedId is String) {
                      setState(() {
                        bookings.removeWhere((b) => b.bookingId == deletedId);
                      });
                    }
                  },

                );
              },
            ),
          );
        },
      ),
    );
  }
}
