import 'package:easyhealth/models/hospital_model.dart';
import 'package:easyhealth/widgets/hospital_card.dart';
import 'package:flutter/material.dart';

class ListViewNewHospital extends StatefulWidget {
  final String? keyword;
  final List<HospitalModel> hospitals;
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
              hospitalId: h.id ?? "",
              imageUrl: (h.image != null && h.image!.isNotEmpty)
                  ? h.image!
                  : "https://i.pinimg.com/736x/9e/19/24/9e192482fc541eb907ec246d1e114c70.jpg",
              name: h.name ?? "",
              address: h.address ?? "",
            );
          },
        ),
      ],
    );
  }
}
