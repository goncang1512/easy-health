import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../utils/fetch.dart';

class ChatUser {
  final String id;
  final String name;
  final String? image;

  const ChatUser({required this.id, required this.name, this.image});

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'],
      name: json['name'],
      image:
          json['image'] ??
          "https://i.pinimg.com/736x/1d/ec/e2/1dece2c8357bdd7cee3b15036344faf5.jpg",
    );
  }
}

class ChatProvider extends ChangeNotifier {
  List<ChatMessage> messages = [
    ChatMessage(
      message: "Hallooo Dok...",
      isSender: false,
      time: DateTime.now(),
    ),
  ];

  void sendMessage(String text) {
    messages.add(
      ChatMessage(message: text, isSender: true, time: DateTime.now()),
    );

    notifyListeners();

    // simulasi balasan admin (opsional)
    Future.delayed(const Duration(seconds: 1), () {
      messages.add(
        ChatMessage(
          message: "Baik, kami bantu ya...",
          isSender: false,
          time: DateTime.now(),
        ),
      );
      notifyListeners();
    });
  }

  Future<ChatUser> getUser(String userId) async {
    final res = await HTTP.get("/api/user/$userId");

    return ChatUser.fromJson(res['result']);
  }
}
