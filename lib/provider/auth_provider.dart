import 'package:flutter/material.dart';
import 'package:easyhealth/utils/fetch.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set _loading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _loading = true;
    try {
      final response = await Fetch.post(
        "/api/sign/register",
        body: {
          "name": name.trim(),
          "email": email.trim(),
          "password": password.trim(),
        },
      );

      debugPrint("Register response: $response");
      return null; // null artinya berhasil
    } catch (e) {
      debugPrint("Register error: $e");
      return e.toString(); // kembalikan error
    } finally {
      _loading = false;
    }
  }

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    _loading = true;
    final response = await Fetch.post(
      "/api/sign/login",
      body: {"email": email.trim(), "password": password.trim()},
    );
    _loading = false;
    // Kalau status false, kembalikan null atau throw error
    return response; // null artinya berhasil
  }
}
