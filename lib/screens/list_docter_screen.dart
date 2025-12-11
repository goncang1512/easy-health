import 'package:easyhealth/models/docter_model.dart';
import 'package:easyhealth/provider/docter_provider.dart';
import 'package:easyhealth/utils/theme.dart';
import 'package:easyhealth/widgets/dokter_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListDocterScreen extends StatefulWidget {
  const ListDocterScreen({super.key});

  @override
  State<ListDocterScreen> createState() => _ListDocterScreen();
}

class _ListDocterScreen extends State<ListDocterScreen> {
  late Future<List<DocterModel>> _futureDocters;
  late String tabs = 'verified';

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

  Future<void> updateDocter(String docterId, String status) async {
    final provider = context.read<DocterProvider>();
    try {
      bool res = await provider.updateStatusDocter(docterId, status);

      // Setelah cancel → Refresh UI
      if (res) {
        await _refreshData(); // panggil fungsi refresh yg kamu sudah buat
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Dokter berhasil di $status")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void changeTabs(String tabsValue) {
    setState(() {
      tabs = tabsValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Dokter"),
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
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 250),
                  Center(child: Text('Tidak ada docter terdaftar')),
                ],
              );
            }

            final docters = snapshot.data;
            final doctersFilter = docters!
                .where((d) => d.status == tabs)
                .toList();

            return Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: tabs == "verified"
                                ? ThemeColors.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            foregroundColor: tabs == "verified"
                                ? ThemeColors.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => changeTabs("verified"),
                          label: Text(
                            "Verified",
                            style: TextStyle(
                              color: tabs == "verified"
                                  ? ThemeColors.primary
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: tabs == "unverified"
                                ? ThemeColors.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            foregroundColor: tabs == "unverified"
                                ? ThemeColors.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => changeTabs("unverified"),
                          label: Text(
                            "Unverified",
                            style: TextStyle(
                              color: tabs == "unverified"
                                  ? ThemeColors.primary
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: Column(
                      children: doctersFilter.map((item) {
                        return DoctorCard(
                          onBookTap: () => updateDocter(
                            item.id,
                            item.status == "verified"
                                ? "unverified"
                                : "verified",
                          ),
                          buttonText: item.status,
                          showHospital: false,
                          imageUrl: item.photoUrl ?? "",
                          name: item.name,
                          specialty: item.specialits,
                          hospital: item.hospital?.name ?? "",
                        );
                      }).toList(),
                    ),
                    // child: ListView.builder(
                    //   itemCount: docters?.length,
                    //   itemBuilder: (context, index) {
                    //     final filtered = docters!
                    //         .where((d) => d.status == tabs)
                    //         .toList();

                    //     final doctor = filtered[index];

                    //     return DoctorCard(
                    //       onBookTap: () => updateDocter(
                    //         doctor.id,
                    //         doctor.status == "verified"
                    //             ? "unverified"
                    //             : "verified",
                    //       ),
                    //       buttonText: doctor.status,
                    //       showHospital: false,
                    //       imageUrl: doctor.photoUrl ?? "",
                    //       name: doctor.name,
                    //       specialty: doctor.specialits,
                    //       hospital: doctor.hospital?.name ?? "",
                    //     );
                    //   },
                    // ),
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
