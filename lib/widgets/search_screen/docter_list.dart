import 'package:easyhealth/models/docter_model.dart';
import 'package:easyhealth/widgets/dokter_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListViewDoctor extends StatefulWidget {
  final String? keyword;
  final List<DocterModel> docters;
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
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 8),
        widget.docters.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true, // <--- penting biar ikut tinggi konten
                padding: EdgeInsets.zero,
                physics:
                    NeverScrollableScrollPhysics(), // <--- biar scroll hanya parent
                itemCount: widget.docters.length,
                itemBuilder: (context, index) {
                  final doctor = widget.docters[index];
                  return DoctorCard(
                    showHospital: widget.showHospital,
                    imageUrl: doctor.photoUrl ?? "",
                    name: doctor.name,
                    specialty: doctor.specialits,
                    hospital: doctor.hospital?.name ?? "",
                    onBookTap: () => context.push("/docter/${doctor.id}"),
                  );
                },
              )
            : Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dokter tidak terdaftar",
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
      ],
    );
  }
}
