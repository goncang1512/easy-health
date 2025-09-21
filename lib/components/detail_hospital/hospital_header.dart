import 'dart:ui';
import 'package:flutter/material.dart';

class HospitalHeader extends StatelessWidget {
  const HospitalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // tinggi header
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// Background foto RS (selalu penuh)
          Positioned.fill(
            bottom: 1,
            child: Image.network(
              "https://i.pinimg.com/1200x/32/26/fa/3226fae8c2fd31e1c49f441c36ed100c.jpg",
              fit: BoxFit.cover,
            ),
          ),

          /// Tombol back & favorite (glassmorphism)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _glassButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                  _glassButton(icon: Icons.favorite_border, onTap: () {}),
                ],
              ),
            ),
          ),

          /// Card info RS (nempel rapi di bawah gambar)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Info RS
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "RS USU",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Color(0xFF10B981),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "Jl. Dr. Mansyur",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// Tombol "Buka 24 Jam"
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFDCFCE7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Buka 24 Jam",
                        style: TextStyle(color: Color(0xFF10B981)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Glass effect button
  Widget _glassButton({required IconData icon, required VoidCallback onTap}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
