import 'package:flutter/material.dart';

class ListConsultation extends StatelessWidget {
  const ListConsultation({super.key});

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
        CardConsultaion(),
        const SizedBox(height: 10),
        CardConsultaion(),
        const SizedBox(height: 10),
        CardConsultaion(),
        const SizedBox(height: 10),
        CardConsultaion(),
        const SizedBox(height: 10),
      ],
    );
  }
}

class CardConsultaion extends StatelessWidget {
  const CardConsultaion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
                "Nama",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
              Text(
                "Dokter",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),

          Column(
            children: [
              Text(
                "10:10",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              Chip(
                label: const Text(
                  "Konfirmasi",
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
