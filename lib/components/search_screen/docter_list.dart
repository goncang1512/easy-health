import 'package:easyhealth/components/dokter_card.dart';
import 'package:easyhealth/pages/docter_screen.dart';
import 'package:easyhealth/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

class Docter {
  final String imageUrl;
  final String name;
  final String address;
  final String hospital;
  final String specialty;
  final String id;

  Docter({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.hospital,
    required this.specialty,
  });
}

class ListViewDoctor extends StatefulWidget {
  final String? keyword;
  final List<Docter> docters;
  final String title;
  final bool showHospital;

  const ListViewDoctor({
    super.key,
    this.keyword,
    required this.docters,
    required this.title,
    this.showHospital = true,
  });

  @override
  State<ListViewDoctor> createState() => _ListDocter();
}

class _ListDocter extends State<ListViewDoctor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true, // <--- penting biar ikut tinggi konten
          padding: EdgeInsets.zero,
          physics:
              NeverScrollableScrollPhysics(), // <--- biar scroll hanya parent
          itemCount: widget.docters.length,
          itemBuilder: (context, index) {
            final h = widget.docters[index];
            return DoctorCard(
              showHospital: widget.showHospital,
              imageUrl: h.imageUrl,
              name: "dr. Toto",
              hospital: "RS USU",
              specialty: "Penyakit dalam",
              onBookTap: () => {
                NavigationHelper.push(context, DocterScreen(docterId: h.id)),
              },
            );
          },
        ),
      ],
    );
  }
}
