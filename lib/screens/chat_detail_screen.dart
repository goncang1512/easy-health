import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easyhealth/provider/message_provider.dart';

class ChatScreen extends StatelessWidget {
  final String roomId;

  const ChatScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final messageProvider = context.watch<MessageProvider>();

    // ✅ Ambil ID user dari session.user.id sesuai struktur UserSession
    final senderId = messageProvider.session?.user.id ?? "unknown";

    return Scaffold(
      appBar: AppBar(title: Text("Chat Room - $roomId")),
      body: Column(
        children: [
          // List pesan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messageProvider.messages.length,
              itemBuilder: (context, index) {
                final msg = messageProvider.messages[index];

                return Align(
                  alignment: msg.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: msg.isMe
                          ? Colors.green.shade100
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.text),
                  ),
                );
              },
            ),
          ),

          // Input box
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageProvider.messageController,
                    decoration: InputDecoration(
                      hintText: "Ketik pesan...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: () {
                    final text = messageProvider.messageController.text;
                    if (text.trim().isNotEmpty) {
                      messageProvider.sendMessage(senderId, roomId, text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
