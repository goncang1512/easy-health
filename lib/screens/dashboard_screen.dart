import 'package:easyhealth/models/stats_model.dart';
import 'package:easyhealth/provider/admin_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/widgets/dashboard/dashbaord_stats.dart';
import 'package:easyhealth/widgets/dashboard/list_consultation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  late Future<StatsDashboardModel?> _futureDashboard;

  @override
  void initState() {
    super.initState();
    _futureDashboard = context.read<AdminProvider>().getStatsDashboard();
  }

  Future<void> _refreshData() async {
    // panggil ulang future dan setState agar FutureBuilder ter-*rebuild*
    setState(() {
      _futureDashboard = context.read<AdminProvider>().getStatsDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SessionManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard ${data.session?.hospital?.name ?? "Admin"}"),
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
                          "/register/hospital/${data.session?.hospital?.id}",
                        );
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
      floatingActionButton: data.session?.hospital != null
          ? FloatingActionButton(
              backgroundColor: Color(0xFF10B981),
              foregroundColor: Colors.white,
              onPressed: () {
                context.push("/add-docter/${data.session?.hospital?.id}");
              },
              child: const Icon(
                Icons.add,
                fontWeight: FontWeight.bold,
                size: 30,
              ),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<StatsDashboardModel?>(
          future: _futureDashboard,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [NothingHospital()],
              );
            }

            final StatsDashboardModel? stats = snapshot.data;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child:
                  data.session?.user.role == "Admin" &&
                      data.session?.hospital == null
                  ? NothingHospital()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "Ringkasan Hari Ini",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DashbaordStats(stats: stats),

                        const SizedBox(height: 10),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: ListConsultation(
                            booking: stats?.bookRange ?? [],
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

class NothingHospital extends StatelessWidget {
  const NothingHospital({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => context.push("/register/hospital"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // rounded corners
            side: BorderSide(color: Colors.greenAccent, width: 2), // border
          ),
          elevation: 5,
        ),
        child: Text(
          "Daftar Rumah Sakit",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
