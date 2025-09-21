import 'package:easyhealth/pages/hospital_screen.dart';
import 'package:easyhealth/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String address;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onTap;
  final String hospitalId;

  const HospitalCard({
    super.key,
    required this.hospitalId,
    required this.imageUrl,
    required this.name,
    required this.address,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // klik keseluruhan card
      borderRadius: BorderRadius.circular(12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            width: 0.5,
            color: const Color.fromARGB(255, 192, 192, 192),
          ),
        ),
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Gambar
              GestureDetector(
                onTap: () {
                  NavigationHelper.push(
                    context,
                    HospitalScreen(hospitalId: hospitalId),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Nama & Alamat
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    NavigationHelper.push(
                      context,
                      HospitalScreen(hospitalId: hospitalId),
                    );
                  },
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
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              // Icon Favorite
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.withValues(
                    alpha: 0.1,
                  ), // background hijau transparan
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: IconButton(
                  onPressed: onFavoriteTap,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
