import 'package:flutter/material.dart';

class TopAuth extends StatelessWidget {
  const TopAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),

        Positioned(
          bottom: -30, // << ini yang bikin dia “menggantung” ke bawah
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981), // hijau seperti gambar
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  "images/stetoscope.png",
                  width: 30,
                  height: 30,
                  color: Colors.white, // kalau mau icon jadi putih
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
