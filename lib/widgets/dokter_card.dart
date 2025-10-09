import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String specialty;
  final String hospital;
  final VoidCallback? onBookTap;
  final bool showHospital;
  final String? buttonText;

  const DoctorCard({
    super.key,
    this.showHospital = true,
    required this.imageUrl,
    required this.name,
    required this.specialty,
    required this.hospital,
    this.onBookTap,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 0.5,
          color: const Color.fromARGB(255, 192, 192, 192),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Foto dokter
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(
                    255,
                    197,
                    197,
                    197,
                  ), // warna border
                  width: 0.5, // ketebalan border
                ),
                borderRadius: BorderRadius.circular(8), // radius border
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 12),

            // Detail dokter
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    specialty,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (showHospital)
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            hospital,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // Tombol Book
            ElevatedButton(
              onPressed: onBookTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
              ),
              child: Text(
                (buttonText == null || buttonText!.isEmpty)
                    ? "Book"
                    : buttonText!,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
