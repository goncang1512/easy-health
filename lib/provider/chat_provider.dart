import 'package:flutter/material.dart';
import '../models/chat_message.dart';

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
      ChatMessage(
        message: text,
        isSender: true,
        time: DateTime.now(),
      ),
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
}
