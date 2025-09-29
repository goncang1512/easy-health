import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:easyhealth/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UseSession {
  static Future<UserSession?> getSession() async {
    final token = await PrefsService.getToken();

    if (token == null) {
      return null;
    }

    final data = await HTTP.get(
      "/api/sign/session",
      headers: {"Authorization": "Bearer $token"},
    );

    return UserSession.fromMap(
      data["result"]["user"],
      data["result"]["session"],
    );
  }

  static void logOut(BuildContext context) async {
    await PrefsService.deleteToken();
    context.go("/login");
  }
}
