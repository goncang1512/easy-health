import 'package:easyhealth/provider/navigation_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late Future<Map<String, dynamic>> homeFuture;

  @override
  void initState() {
    super.initState();
    homeFuture = getHomeRecomend();
  }

  Future<Map<String, dynamic>> getHomeRecomend() async {
    try {
      final response = await HTTP.get("/api/home/user");
      return {
        "hospitals": response['result']['hospitals'],
        "docters": response['result']['docters'],
      };
    } catch (error) {
      return {"hospitals": [], "docters": []};
    }
  }

  Future<void> refreshHome() async {
    setState(() {
      homeFuture = getHomeRecomend();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF1CB079);
    final dataSession = context.watch<SessionManager>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshHome,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              Container(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 24,
                  right: 24,
                  bottom: 30,
                ),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                          image: NetworkImage(
                            dataSession.session?.user.image ??
                                'https://i.pinimg.com/736x/9d/16/4e/9d164e4e074d11ce4de0a508914537a8.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bagaimana Kabarmu?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dataSession.session?.user.name ?? "",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ================= KATEGORI =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kategori",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCategoryItem(
                          title: "Booking",
                          icon: Icons.apartment,
                          color: primaryGreen,
                          onTap: () {
                            context.read<NavigationProvider>().shell?.goBranch(
                              1,
                            );
                          },
                        ),
                        _buildCategoryItem(
                          title: "Daftar Dokter",
                          icon: Icons.person_add,
                          color: primaryGreen,
                          onTap: () => context.push('/add-docter'),
                        ),
                        _buildCategoryItem(
                          title: "Daftar RS",
                          icon: Icons.local_hospital,
                          color: primaryGreen,
                          onTap: () => context.push('/register/hospital'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ================= DATA HOME =================
              FutureBuilder<Map<String, dynamic>>(
                future: homeFuture,
                builder: (context, snapshot) {
                  // -------- LOADING --------
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  // -------- ERROR --------
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Center(
                        child: Text(
                          "Gagal memuat data\nTarik ke bawah untuk refresh",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  final docters = snapshot.data?['docters'] as List? ?? [];
                  final hospitals = snapshot.data?['hospitals'] as List? ?? [];

                  // -------- EMPTY --------
                  if (docters.isEmpty && hospitals.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Center(
                        child: Text(
                          "Data belum tersedia\nTarik ke bawah untuk refresh",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      // ===== RUMAH SAKIT =====
                      _buildSectionHeader("Rumah Sakit", primaryGreen, () {
                        context.read<NavigationProvider>().shell?.goBranch(2);
                      }),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: hospitals.map((hospital) {
                            return GestureDetector(
                              onTap: () =>
                                  context.push("/hospital/${hospital['id']}"),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildHospitalCard(
                                  hospital['name'],
                                  hospital['address'],
                                  hospital['image'],
                                  primaryGreen,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ===== DOKTER =====
                      _buildSectionHeader("Dokter", primaryGreen, () {
                        context.read<NavigationProvider>().shell?.goBranch(2);
                      }),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: docters.map((doctor) {
                            return GestureDetector(
                              onTap: () =>
                                  context.push("/docter/${doctor['id']}"),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildDoctorCard(
                                  doctor['user']['name'],
                                  doctor['specialits'],
                                  doctor['hospital']['name'],
                                  doctor['photoUrl'],
                                  primaryGreen,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET HELPER: Section Title
  Widget _buildSectionHeader(String title, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  "Lihat Lagi",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward, color: color, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET HELPER: Kartu Kategori (DIPERBAIKI)
  // Menggunakan Named Parameter ({}) agar lebih aman dan rapi
  Widget _buildCategoryItem({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap, // Wajib diisi
  }) {
    return GestureDetector(
      onTap: onTap, // Menjalankan fungsi navigasi
      child: Container(
        width: 100,
        height: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET HELPER: Kartu Rumah Sakit
  Widget _buildHospitalCard(
    String name,
    String address,
    String imageUrl,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (ctx, _, __) =>
                  Container(width: 80, height: 60, color: Colors.grey[200]),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET HELPER: Kartu Dokter
  Widget _buildDoctorCard(
    String name,
    String specialist,
    String hospital,
    String imageUrl,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (ctx, _, __) =>
                  Container(width: 70, height: 70, color: Colors.grey[200]),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialist,
                  style: TextStyle(
                    fontSize: 13,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      hospital,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
