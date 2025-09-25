import 'package:easyhealth/widgets/hospital_card.dart';
import 'package:flutter/material.dart';

class Hospital {
  final String imageUrl;
  final String name;
  final String address;
  final String hospitalId;

  Hospital({
    required this.imageUrl,
    required this.hospitalId,
    required this.name,
    required this.address,
  });
}

class ListViewNewHospital extends StatefulWidget {
  final String? keyword;
  final List<Hospital> hospitals;
  final String title;
  const ListViewNewHospital({
    super.key,
    this.keyword,
    required this.hospitals,
    required this.title,
  });

  @override
  State<ListViewNewHospital> createState() => _ListNewHospital();
}

class _ListNewHospital extends State<ListViewNewHospital> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        ListView.builder(
          shrinkWrap: true, // <--- penting biar ikut tinggi konten
          physics:
              NeverScrollableScrollPhysics(), // <--- biar scroll hanya parent
          itemCount: widget.hospitals.length,
          itemBuilder: (context, index) {
            final h = widget.hospitals[index];
            return HospitalCard(
              hospitalId: h.hospitalId,
              imageUrl: h.imageUrl,
              name: h.name,
              address: h.address,
            );
          },
        ),
      ],
    );
  }
}
