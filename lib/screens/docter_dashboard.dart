import 'package:easyhealth/models/appointment_model.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/theme.dart';
import 'package:easyhealth/widgets/docter_dashboard/card_pacient.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DocterDashboard extends StatefulWidget {
  const DocterDashboard({super.key});

  @override
  State<DocterDashboard> createState() => _DocterDashboard();
}

class _DocterDashboard extends State<DocterDashboard> {
  Future<List<Appointment>>? futureDashboard;

  @override
  void initState() {
    super.initState();
    final session = context.read<SessionManager>().session;
    futureDashboard = fetchDoctorDashboard(session!.docter!.id);
  }

  Future<void> refreshDashboard() async {
    final session = context.read<SessionManager>().session;

    setState(() {
      futureDashboard = fetchDoctorDashboard(session!.docter!.id);
    });

    await futureDashboard; // biar refresh indicator menunggu
  }

  Future<void> cancelBooking(String bookingId, String status) async {
    try {
      bool res = await updateStatusBooking(bookingId, status);

      // Setelah cancel → Refresh UI
      if (res) {
        await refreshDashboard(); // panggil fungsi refresh yg kamu sudah buat
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Booking berhasil di $status")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SessionManager>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard ${data.session?.user.name ?? "Docter"}"),
        centerTitle: false,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12), // padding kiri & kanan
            child: SizedBox(
              width: 40,
              height: 40,
              child: data.session?.hospital != null
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context.push(
                          "/edit-docter/${data.session?.docter?.id}",
                        );
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshDashboard,
        color: ThemeColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 10),
            child: FutureBuilder(
              future: futureDashboard,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 300,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final appointments = snapshot.data ?? [];

                if (appointments.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text("Belum ada booking"),
                    ),
                  );
                }

                return Column(
                  children: appointments.map((item) {
                    return AppointmentCard(
                      name: item.name,
                      status: item.status,
                      time: item.bookTime,
                      date: item.bookDate,
                      onCancel: () => cancelBooking(
                        item.id,
                        item.status == "confirm" ? "canceled" : "confirm",
                      ),
                      onFinish: () => cancelBooking(item.id, "finish"),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
