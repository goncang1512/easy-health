import 'package:easyhealth/provider/booking_provider.dart';
import 'package:easyhealth/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateBooking extends StatelessWidget {
  final String docterId;
  final String hospitalId;
  const CreateBooking({
    super.key,
    required this.docterId,
    required this.hospitalId,
  });

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: booking.isLoading
                  ? null
                  : () async {
                      final data = await booking.onSubmit(hospitalId, docterId);

                      if (data['status'] == false) {
                        Alert.showBanner("$data['message']", context);
                        return;
                      }

                      context.go("/booking");
                    },
              icon: booking.isLoading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(Icons.calendar_today, color: Colors.white),
              label: const Text(
                "Booking Sekarang",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF10B981),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Dengan melanjutkan, Anda menyetujui syarat dan ketentuan kami",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
