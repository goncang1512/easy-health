import 'package:easyhealth/widgets/chat_screen/chat_item.dart';
import 'package:easyhealth/widgets/chat_screen/search_chat.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatList();
}

class _ChatList extends State<ChatListScreen> {
  final TextEditingController keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarChatLIst(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputSearchComponent(
              controller: keyword,
              onSubmit: (_) {},
              placeholder: "Cari pesan",
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [

                  /// CHAT 1
                  ChatItem(
                    avatarUrl:
                        "https://i.pinimg.com/736x/67/e6/36/67e6360cb61bc90fb9414a9537f41b7c.jpg",
                    name: "Goncang",
                    message: "Hello",
                    time: "10:00 PM",
                    roomId: "room_1", // ✅ WAJIB ADA
                  ),

                  /// CHAT 2
                  ChatItem(
                    avatarUrl:
                        "https://i.pinimg.com/736x/67/e6/36/67e6360cb61bc90fb9414a9537f41b7c.jpg",
                    name: "Admin",
                    message: "Pesan dari admin",
                    time: "09:30 PM",
                    roomId: "room_2",
                  ),

                  /// CHAT 3
                  ChatItem(
                    avatarUrl:
                        "https://i.pinimg.com/736x/67/e6/36/67e6360cb61bc90fb9414a9537f41b7c.jpg",
                    name: "Dokter",
                    message: "Halo, ada yang bisa dibantu?",
                    time: "08:15 PM",
                    roomId: "room_3",
                  ),

                  /// CHAT 4
                  ChatItem(
                    avatarUrl:
                        "https://i.pinimg.com/736x/67/e6/36/67e6360cb61bc90fb9414a9537f41b7c.jpg",
                    name: "Customer Service",
                    message: "Silakan tunggu ya",
                    time: "07:45 PM",
                    roomId: "room_4",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChatLIst extends StatelessWidget implements PreferredSizeWidget {
  const BarChatLIst({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: context.canPop()
          ? IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      title: const Text("Pesan Admin"),
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
