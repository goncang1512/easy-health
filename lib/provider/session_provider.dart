import 'package:easyhealth/utils/secure_storage.dart';
import 'package:flutter/material.dart';

import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/get_session.dart';

class SessionManager extends ChangeNotifier {
  UserSession? _session;
  UserSession? get session => _session;

  Future<void> loadSession() async {
    _session = await UseSession.getSession();
    notifyListeners();
  }

  Future<void> clearSession() async {
    await PrefsService.deleteToken();
    _session = null;
    notifyListeners();
  }
}
