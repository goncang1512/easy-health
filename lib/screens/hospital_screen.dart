import 'package:easyhealth/models/docter_model.dart';
import 'package:easyhealth/models/hospital_model.dart';
import 'package:easyhealth/utils/fetch.dart';
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
  Future<Map<String, dynamic>> getHospitalDetail() async {
    final data = await HTTP.get("/api/hospital/detail/${widget.hospitalId}");

    final hospital = HospitalModel.fromJson(data['result']);
    final docters = (data["result"]["docter"] as List<dynamic>)
        .map((item) => DocterModel.fromJson(item))
        .toList();

    return {"hospital": hospital, "docters": docters};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>>(
        future: getHospitalDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Tidak ada data"));
          }

          final HospitalModel? hospital = snapshot.data!["hospital"];
          final List<DocterModel> docters = snapshot.data!["docters"];

          return SingleChildScrollView(
            child: Column(
              children: [
                HospitalHeader(hospital: hospital),
                TagHospital(badroom: hospital?.room ?? 0),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
