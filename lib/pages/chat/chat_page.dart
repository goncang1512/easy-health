import 'package:easyhealth/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/chat_provider.dart';

class ChatPage extends StatelessWidget {
  final String hospitalName;
  final String bookingId;

  const ChatPage({
    super.key,
    required this.hospitalName,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        title: Text("Admin $hospitalName"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.messages.length,
              itemBuilder: (context, i) {
                final msg = provider.messages[i];
                return Align(
                  alignment:
                      msg.isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: msg.isSender
                          ? ThemeColors.primary
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.message),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Ketik Pesan Anda",
                      filled: true,
                      fillColor: ThemeColors.secondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    if (controller.text.trim().isNotEmpty) {
                      provider.sendMessage(controller.text.trim());
                      controller.clear();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: ThemeColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
