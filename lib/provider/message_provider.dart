import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:flutter/material.dart';

class MessageProvider with ChangeNotifier {
  UserSession? session;

  MessageProvider({required this.session});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // List pesan
  List<Message> messages = [];

  // Controller untuk input
  TextEditingController messageController = TextEditingController();

  // Create room
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

  // Fetch semua pesan di room
  Future<void> fetchChat(String roomId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final result = await HTTP.get("/api/message/room/$roomId");
      if (result['status']) {
        messages = (result['result'] as List).map((msg) {
          final isMe = msg['senderId'] == session?.user.id;
          return Message(text: msg['text'], isMe: isMe);
        }).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Failed fetch chat: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Send message & update list
  Future<Map<String, dynamic>> sendMessage(
    String senderId,
    String roomId,
    String text,
  ) async {
    if (text.trim().isEmpty) return {"status": false, "message": "Text empty"};

    _isLoading = true;
    notifyListeners();

    try {
      final result = await HTTP.post(
        "/api/message/chat",
        body: {"senderId": senderId, "roomId": roomId, "text": text},
      );

      if (result["status"]) {
        messages.add(Message(text: text, isMe: true));
        notifyListeners();
        return {"status": true, "message": text};
      } else {
        return {"status": false, "message": result["message"] ?? "Failed"};
      }
    } catch (e) {
      return {"status": false, "message": "Error sending message"};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
