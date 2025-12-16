import 'package:easyhealth/models/message_model.dart';
import 'package:easyhealth/provider/message_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatScreenMessage extends StatefulWidget {
  final String roomId;
  const ChatScreenMessage({super.key, required this.roomId});

  @override
  State<ChatScreenMessage> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreenMessage> {
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MessageProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: context.canPop()
            ? IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back),
              )
            : null,
        title: FutureBuilder(
          future: provider.getHospitalRoomChatName(widget.roomId),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("Belum ada pesan"));
            }

            final rs = snapshot.data;

            return Text(rs['name'] ?? "Room Chat");
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // biar icon/teks jadi hitam
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 25,
            top: 10,
          ),
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
                  color: ThemeColors.primary,
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

      body: StreamBuilder<List<MessageModel>>(
        stream: provider.getMessages(widget.roomId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Belum ada pesan"));
          }

          final messages = snapshot.data!;

          final bottomPadding = MediaQuery.viewInsetsOf(context).bottom + 100;
          return ListView.builder(
            reverse: true,
            padding: EdgeInsets.only(
              top: 12,
              right: 12,
              left: 12,
              bottom: bottomPadding,
            ),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];

              return Align(
                alignment:
                    msg.senderId ==
                        context.read<SessionManager>().session!.user.id
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    right: 12,
                    left: 12,
                  ),
                  decoration: BoxDecoration(
                    color:
                        msg.senderId ==
                            context.read<SessionManager>().session!.user.id
                        ? ThemeColors.primary
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    msg.text ?? "",
                    style: TextStyle(
                      color:
                          msg.senderId ==
                              context.read<SessionManager>().session!.user.id
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
