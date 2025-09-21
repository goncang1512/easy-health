import 'package:flutter/material.dart';

/// Navigasi helper biar gampang dipakai
class NavigationHelper {
  /// Pindah ke halaman baru (masih bisa back)
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  /// Ganti halaman sekarang dengan halaman baru (tidak bisa back ke sebelumnya)
  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  /// Pindah ke halaman baru dan hapus semua stack sebelumnya
  static void pushAndRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  /// Kembali ke halaman sebelumnya
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
