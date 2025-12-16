import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF1CB079);

    return Scaffold(
      body: Stack(
        children: [
          // Konten Utama
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 30), // Tambahan padding bawah agar aman
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER SECTION
                Container(
                  padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          image: const DecorationImage(
                            image: NetworkImage('https://i.pravatar.cc/150?img=11'), // Placeholder user
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Teks Salam
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Bagaimana Kabarmu?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Bung Karno",
                            style: TextStyle(
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

                // 2. KATEGORI SECTION (SUDAH DIPERBAIKI)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Kategori",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Tombol Booking
                          _buildCategoryItem(
                            title: "Booking",
                            icon: Icons.apartment,
                            color: primaryGreen,
                            onTap: () {
                              context.push('/booking');
                            },
                          ),
                          // Tombol Dokter
                          _buildCategoryItem(
                            title: "Daftar Dokter",
                            icon: Icons.person_add,
                            color: primaryGreen,
                            onTap: () {
                              context.push('/add-docter');
                            },
                          ),
                          // Tombol RS
                          _buildCategoryItem(
                            title: "Daftar RS",
                            icon: Icons.local_hospital,
                            color: primaryGreen,
                            onTap: () {
                              context.push('/register/hospital');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 3. RUMAH SAKIT SECTION
                _buildSectionHeader("Rumah Sakit", primaryGreen),
                const SizedBox(height: 10),
                // List Rumah Sakit
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildHospitalCard(
                          "RS USU",
                          "Jl. Dr. Mansyur, Medan",
                          "https://upload.wikimedia.org/wikipedia/commons/6/63/RS_USU.jpg",
                          primaryGreen
                      ),
                      const SizedBox(height: 12),
                      _buildHospitalCard(
                          "RS USU",
                          "Jl. Dr. Mansyur, Medan",
                          "https://upload.wikimedia.org/wikipedia/commons/6/63/RS_USU.jpg",
                          primaryGreen
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 4. DOKTER SECTION
                _buildSectionHeader("Dokter", primaryGreen),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildDoctorCard(
                          "dr. Bima Santosa, Sp.A",
                          "Spesialis Anak",
                          "RS Hermina Depok",
                          "https://i.pravatar.cc/150?img=33",
                          primaryGreen
                      ),
                      const SizedBox(height: 12),
                      _buildDoctorCard(
                          "dr. Bima Santosa, Sp.A",
                          "Spesialis Anak",
                          "RS Hermina Depok",
                          "https://i.pravatar.cc/150?img=33",
                          primaryGreen
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET HELPER: Section Title
  Widget _buildSectionHeader(String title, Color color) {
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
          Row(
            children: [
              Text(
                "Lihat\nLagi",
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
          )
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
  Widget _buildHospitalCard(String name, String address, String imageUrl, Color color) {
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
              errorBuilder: (ctx, _, __) => Container(width: 80, height: 60, color: Colors.grey[200]),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
  Widget _buildDoctorCard(String name, String specialist, String hospital, String imageUrl, Color color) {
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
              errorBuilder: (ctx, _, __) => Container(width: 70, height: 70, color: Colors.grey[200]),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  specialist,
                  style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w600),
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