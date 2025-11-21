import 'package:easyhealth/utils/secure_storage.dart';
import 'package:flutter/material.dart';

import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/get_session.dart';

class SessionManager extends ChangeNotifier {
  UserSession? _session;
  UserSession? _tempSession;
  bool _isLoading = false;

  UserSession? get session => _tempSession ?? _session;
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

  Future<void> refreshSession() async {
    if (_session == null) return;

    try {
      final updated = await UseSession.refreshSession();
      if (updated != null) {
        // update _session dengan user/hospital terbaru
        _session = _session!.copyWith(
          user: updated.user,
          session: updated.session,
          hospital: updated.hospital,
          docter: updated.docter,
        );
        _tempSession = null; // bersihkan temp session
        notifyListeners();
      }
    } catch (_) {}
  }
}
