import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:flutter/material.dart';

class MessageProvider with ChangeNotifier {
  UserSession? session;

  MessageProvider({required this.session});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Map<String, dynamic>> createRoom(
    String senderId,
    String receiverId,
  ) async {
    try {
      final data = await HTTP.post(
        "/api/message/room",
        body: {"senderId": senderId, "receiverId": receiverId},
      );

      return {"status": data['status'], "roomId": data["result"]["id"]};
    } catch (error) {
      return {"status": false, "roomId": null};
    }
  }

  Future<Map<String, dynamic>> sendMessage(
    String senderId,
    String roomId,
    String text,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await HTTP.post(
        "/api/message/chat",
        body: {"senderId": senderId, "roomId": roomId, "text": text},
      );

      return {"status": result["status"], "message": result["message"]};
    } catch (error) {
      return {"status": false, "message": "Error request"};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
