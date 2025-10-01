import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:easyhealth/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

    if (!data["status"]) {
      return null;
    }

    return UserSession.fromMap(
      data["result"]["user"],
      data["result"]["session"],
    );
  }

  static void logOut(BuildContext context) async {
    await context.read<SessionManager>().clearSession();
    // ignore: use_build_context_synchronously
    context.go("/login");
  }
}
