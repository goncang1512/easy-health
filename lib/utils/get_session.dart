import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:easyhealth/utils/secure_storage.dart';

class UseSession {
  static Future<UserSession> getSession() async {
    final token = await PrefsService.getToken();

    final data = await Fetch.get(
      "/api/sign/session",
      fromJson: (json) => UserSession.fromMap(json),
      headers: {"Authorization": "Bearer $token"},
    );

    return data;
  }
}
