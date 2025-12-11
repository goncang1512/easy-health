import 'package:easyhealth/utils/get_session.dart';
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
    _loading = true;
    notifyListeners();

    final response = await HTTP.post(
      "/api/sign/register",
      body: {
        "name": name.trim(),
        "email": email.trim(),
        "password": password.trim(),
        "confirmPassword": confirmPassword.trim(),
      },
    );
    if (response['status'] == false) {
      _loading = false;
      notifyListeners();

      return {"status": false, "message": response['message'], "result": null};
    }

    _loading = false;
    notifyListeners();

    return response;
  }

  Future login({required String email, required String password}) async {
    _loading = true;
    notifyListeners();
    final data = await HTTP.post(
      "/api/sign/login",
      body: {"email": email.trim(), "password": password.trim()},
    );

    if (data['status'] == false) {
      _loading = false;
      notifyListeners();

      return {"status": false, "message": data['message'], "result": null};
    }

    await statusUser(data['result']['user']['id'], "online");
    _loading = false;
    notifyListeners();

    return data;
  }
}
