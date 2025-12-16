import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna hijau utama diambil dari screenshot
    final Color primaryGreen = const Color(0xFF1CB079);

    return Scaffold(
      body: Stack(
        children: [
          // Konten Utama
          SingleChildScrollView(
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

                // 2. KATEGORI SECTION
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
                          _buildCategoryItem("Booking", Icons.apartment, primaryGreen),
                          _buildCategoryItem("Daftar Dokter", Icons.person_search, primaryGreen),
                          _buildCategoryItem("Daftar RS", Icons.local_hospital, primaryGreen),
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
                          "https://upload.wikimedia.org/wikipedia/commons/6/63/RS_USU.jpg", // Ganti dengan aset lokal jika ada
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
                          "https://i.pravatar.cc/150?img=33", // Foto dokter placeholder
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
                      const SizedBox(height: 80), // Space extra agar tidak tertutup nav bar
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

  // WIDGET HELPER: Section Title dengan "Lihat Lagi"
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
          // Sesuai desain, tombol lihat lagi ada di sebelah kanan
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

  // WIDGET HELPER: Kartu Kategori (Kotak Putih)
  Widget _buildCategoryItem(String title, IconData icon, Color color) {
    return Container(
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
          // Gambar RS
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
          // Info Teks
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
          // Foto Dokter
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
          // Info Teks
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