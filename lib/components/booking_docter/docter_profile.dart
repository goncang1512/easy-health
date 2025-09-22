import 'package:flutter/material.dart';

class DocterProfile extends StatelessWidget {
  const DocterProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle, // lingkaran
              border: Border.all(
                color: Colors.grey, // warna border
                width: 0.5, // ketebalan border
              ),
            ),
            child: ClipOval(
              child: Image.network(
                "https://i.pinimg.com/736x/51/6b/27/516b27678c97b8a5cfd5fe92c3dae7ed.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "dr. Toto",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Spesialis penyakit dalam",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
