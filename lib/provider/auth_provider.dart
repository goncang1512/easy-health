import 'package:flutter/material.dart';
import 'package:easyhealth/utils/fetch.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set _loading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await HTTP.post(
      "/api/sign/register",
      body: {
        "name": name.trim(),
        "email": email.trim(),
        "password": password.trim(),
        "confirmPassword": confirmPassword.trim(),
      },
    );
    _loading = false;

    return response;
  }

  Future login({required String email, required String password}) async {
    _loading = true;

    final data = await HTTP.post(
      "/api/sign/login",
      body: {"email": email.trim(), "password": password.trim()},
    );

    _loading = false;

    return data;
  }
}
