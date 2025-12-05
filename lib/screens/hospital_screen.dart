import 'package:easyhealth/models/admin_model.dart';
import 'package:easyhealth/models/docter_model.dart';
import 'package:easyhealth/models/hospital_model.dart';
import 'package:easyhealth/provider/message_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:easyhealth/utils/theme.dart';
import 'package:easyhealth/widgets/detail_hospital/hospital_header.dart';
import 'package:easyhealth/widgets/detail_hospital/tag_hospital.dart';
import 'package:easyhealth/widgets/search_screen/docter_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HospitalScreen extends StatefulWidget {
  final String hospitalId;
  const HospitalScreen({super.key, required this.hospitalId});

  @override
  State<HospitalScreen> createState() => _HospitalPage();
}

class _HospitalPage extends State<HospitalScreen> {
  late Future<Map<String, dynamic>> _futureHospital;
  late List<AdminModel> admin;

  @override
  void initState() {
    super.initState();
    _futureHospital = getHospitalDetail();
  }

  Future<void> _refreshData() async {
    // panggil ulang future dan setState agar FutureBuilder ter-*rebuild*
    setState(() {
      _futureHospital = getHospitalDetail();
    });
  }

  Future<Map<String, dynamic>> getHospitalDetail() async {
    final data = await HTTP.get("/api/hospital/detail/${widget.hospitalId}");

    final hospital = HospitalModel.fromJson(data['result']);
    final docters = (data["result"]["docter"] as List<dynamic>)
        .map((item) => DocterModel.fromJson(item))
        .toList();

    setState(() {
      admin = (data['result']['admin'] as List)
          .map((item) => AdminModel.fromJson(item))
          .toList();
    });

    return {"hospital": hospital, "docters": docters};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
        ),
        padding: EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity, // biar full lebar
          child: ElevatedButton(
            onPressed: () async {
              final session = context.read<SessionManager>();
              final message = context.read<MessageProvider>();

              final Map<String, dynamic> result = await message.createRoom(
                session.session?.user.id ?? "",
                admin[0].user.id,
              );

              if (result['status']) {
                context.push("/chat-room/${result['roomId']}");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ), // cukup vertical saja
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: const Text(
              "Kirim Pesan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<Map<String, dynamic>>(
          future: _futureHospital,
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
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  HospitalHeader(hospital: hospital),
                  TagHospital(
                    badroom: hospital?.room ?? 0,
                    docterCount: docters.length,
                  ),
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
      ),
    );
  }
}
