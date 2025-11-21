// ignore_for_file: use_build_context_synchronously

import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:easyhealth/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UseSession {
  static Future<UserSession?> getSession() async {
    try {
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
        data['result']['hospital'],
        data['result']['docter'],
      );
    } catch (error) {
      return null;
    }
  }

  static void logOut(BuildContext context) async {
    final provider = context.read<SessionManager>();

    await statusUser(provider.session?.user.id ?? '', "offline");

    await provider.clearSession();
    context.go("/login");
  }

  static Future<UserSession?> refreshSession() async {
    return getSession(); // bisa di-extend kalau ada endpoint khusus update data
  }
}

Future<void> statusUser(String userId, String event) async {
  await HTTP.post("/api/socket/auth", body: {"userId": userId, "event": event});
}
