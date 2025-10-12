import 'package:easyhealth/models/stats_model.dart';
import 'package:flutter/material.dart';

class ListConsultation extends StatelessWidget {
  final List<BookRange> booking;
  const ListConsultation({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Konsultasi Mendatang (6 jam)",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),

        ListView.builder(
          shrinkWrap: true, // penting: biar tinggi mengikuti isi
          physics: const NeverScrollableScrollPhysics(),
          itemCount: booking.length,
          itemBuilder: (context, index) {
            final konsul = booking[index];

            return Column(
              children: [
                CardConsultaion(book: konsul),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ],
    );
  }
}

class CardConsultaion extends StatelessWidget {
  final BookRange book;
  const CardConsultaion({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // 👉 ini background color-nya
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 0.4,
          color: const Color.fromARGB(255, 197, 197, 197),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                book.name,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
              Text(
                book.docter.name,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),

          Column(
            children: [
              Text(
                book.bookTime,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              Chip(
                label: Text(
                  book.status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
