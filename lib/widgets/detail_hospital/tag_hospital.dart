import 'package:flutter/material.dart';

class TagHospital extends StatelessWidget {
  final int badroom;
  final int docterCount;
  const TagHospital({
    super.key,
    required this.badroom,
    required this.docterCount,
  });

  Widget buildItem(IconData icon, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFDCFCE7), // hijau muda
          child: Icon(
            icon,
            size: 28,
            color: const Color(0xFF059669), // hijau gelap
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF374151), // abu-abu tua
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16), // kasih jarak atas 16px
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildItem(Icons.medical_services, "$docterCount Dokter"),
          buildItem(Icons.bed, "$badroom Bed"),
          buildItem(Icons.local_hospital, "IGD 24/7"),
        ],
      ),
    );
  }
}
