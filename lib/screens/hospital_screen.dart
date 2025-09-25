import 'package:easyhealth/widgets/detail_hospital/hospital_header.dart';
import 'package:easyhealth/widgets/detail_hospital/tag_hospital.dart';
import 'package:easyhealth/widgets/search_screen/docter_list.dart';
import 'package:flutter/material.dart';

class HospitalScreen extends StatefulWidget {
  final String hospitalId;
  const HospitalScreen({super.key, required this.hospitalId});

  @override
  State<HospitalScreen> createState() => _HospitalPage();
}

class _HospitalPage extends State<HospitalScreen> {
  final List<Docter> docters = List.generate(
    5,
    (i) => Docter(
      id: "${i + 1}",
      imageUrl:
          'https://i.pinimg.com/736x/c2/db/2d/c2db2da630a1d117a3e1297ed7fd9b96.jpg',
      name: 'RS Contoh #${i + 1}',
      address: 'Kota ${i + 1}',
      hospital: "RS ${i + 1}",
      specialty: "Spesialis ${i + 1}",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HospitalHeader(),
            TagHospital(),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 20,
                horizontal: 12,
              ),
              child: ListViewDoctor(
                docters: docters,
                title: "Daftar Dokter",
                showHospital: false,
              ),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       "Daftar Dokter",
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              //     ),
              //     DoctorCard(
              //       showHospital: false,
              //       onBookTap: () => {},
              //       imageUrl:
              //           "https://i.pinimg.com/736x/51/6b/27/516b27678c97b8a5cfd5fe92c3dae7ed.jpg",
              //       name: "dr. Marpaung",
              //       specialty: "Spesialis THT",
              //       hospital: "RS Metamedika",
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
