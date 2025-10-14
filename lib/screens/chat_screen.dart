import 'package:easyhealth/provider/message_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;
  const ChatScreen({super.key, required this.roomId});

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MessageProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back),
              )
            : null,
        title: Text("Room Chat"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.filter_alt, color: Colors.green),
        //     onPressed: () {
        //       // aksi filter
        //     },
        //   ),
        // ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // biar icon/teks jadi hitam
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6, top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
          ),
          child: Row(
            children: [
              // Text Field
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextFormField(
                    controller: message,
                    decoration: const InputDecoration(
                      hintText: "Ketik pesan...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Tombol Kirim
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IconButton(
                  icon: provider.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.send, color: Colors.white),
                  onPressed: () async {
                    final session = context.read<SessionManager>();
                    Map<String, dynamic> res = await provider.sendMessage(
                      session.session?.user.id ?? "",
                      widget.roomId,
                      message.text,
                    );

                    if (res['status']) {
                      message.clear();
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      body: Center(child: Text("Chat room")),
    );
  }
}
