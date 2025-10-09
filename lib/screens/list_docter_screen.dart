import 'package:easyhealth/models/docter_model.dart';
import 'package:easyhealth/provider/docter_provider.dart';
import 'package:easyhealth/widgets/dokter_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListDocterScreen extends StatefulWidget {
  const ListDocterScreen({super.key});

  @override
  State<ListDocterScreen> createState() => _ListDocterScreen();
}

class _ListDocterScreen extends State<ListDocterScreen> {
  late Future<List<DocterModel>> _futureDocters;

  @override
  void initState() {
    super.initState();
    _futureDocters = context.read<DocterProvider>().getListDocter();
  }

  Future<void> _refreshData() async {
    // panggil ulang future dan setState agar FutureBuilder ter-*rebuild*
    setState(() {
      _futureDocters = context.read<DocterProvider>().getListDocter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Dokter",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF10B981),
        foregroundColor: Colors.white,
        // biar icon/teks jadi hitam
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<DocterModel>>(
          future: _futureDocters,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No doctors found'));
            }

            final docters = snapshot.data;

            return Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              child: ListView.builder(
                itemCount: docters?.length,
                itemBuilder: (context, index) {
                  final doctor = docters?[index];
                  return DoctorCard(
                    onBookTap: () {
                      context.push("/edit-docter/${doctor?.id}");
                    },
                    buttonText: "Edit",
                    showHospital: false,
                    imageUrl: doctor?.photoUrl ?? "",
                    name: doctor?.name ?? "",
                    specialty: doctor?.specialits ?? "",
                    hospital: doctor?.hospital?.name ?? "",
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
