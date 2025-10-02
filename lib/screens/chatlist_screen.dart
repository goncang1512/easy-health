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
      appBar: BarChatLIst(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputSearchComponent(
              controller: keyword,
              onSubmit: (_) {},
              placeholder: "Cari pesan",
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  ChatItem(
                    avatarUrl:
                        "https://i.pinimg.com/736x/67/e6/36/67e6360cb61bc90fb9414a9537f41b7c.jpg",
                    name: "Goncang",
                    message: "Hello",
                    time: "10:00 PM",
                  ),
                  ChatItem(
                    avatarUrl:
                        "https://i.pinimg.com/736x/67/e6/36/67e6360cb61bc90fb9414a9537f41b7c.jpg",
                    name: "Goncang",
                    message: "Hello",
                    time: "10:00 PM",
                  ),
                  ChatItem(
                    avatarUrl:
                        "https://i.pinimg.com/736x/67/e6/36/67e6360cb61bc90fb9414a9537f41b7c.jpg",
                    name: "Goncang",
                    message: "Hello",
                    time: "10:00 PM",
                  ),
                  ChatItem(
                    avatarUrl:
                        "https://i.pinimg.com/736x/67/e6/36/67e6360cb61bc90fb9414a9537f41b7c.jpg",
                    name: "Goncang",
                    message: "Hello",
                    time: "10:00 PM",
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
      title: Text("Pesan Admin"),
      centerTitle: false,
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
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
