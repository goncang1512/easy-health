import 'package:easyhealth/utils/secure_storage.dart';
import 'package:flutter/material.dart';

import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/get_session.dart';

class SessionManager extends ChangeNotifier {
  UserSession? _session;
  bool _isLoading = false;

  UserSession? get session => _session;
  bool get isLoading => _isLoading;

  Future<void> loadSession() async {
    _isLoading = true;
    notifyListeners();

    try {
      _session = await UseSession.getSession();
    } catch (e) {
      _session = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearSession() async {
    await PrefsService.deleteToken();
    _session = null;
    notifyListeners();
  }
}
