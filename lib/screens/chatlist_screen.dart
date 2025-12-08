import 'package:easyhealth/provider/chat_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/services/firestore_service.dart';
import 'package:easyhealth/widgets/chat_screen/chat_item.dart';
import 'package:easyhealth/widgets/chat_screen/search_chat.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController keyword = TextEditingController();
  final firebaseService = FirestoreService();

  // cache user biar tidak fetch terus menerus
  final Map<String, ChatUser> userCache = {};
  bool isFetchingUsers = false;

  Future<void> fetchUsersOnce(List<dynamic> rooms, ChatProvider chat) async {
    if (isFetchingUsers) return;
    isFetchingUsers = true;

    final ids = rooms.map((e) => e["userAId"]).toSet().toList();

    for (final id in ids) {
      if (!userCache.containsKey(id)) {
        final user = await chat.getUser(id);
        userCache[id] = user;
      }
    }

    isFetchingUsers = false;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hospital = context.watch<SessionManager>().session?.hospital;
    final chat = context.watch<ChatProvider>();

    return Scaffold(
      appBar: BarChatList(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputSearchComponent(
              controller: keyword,
              onSubmit: (_) {},
              placeholder: "Cari pesan",
            ),

            // ================= STREAM BUILDER =================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: StreamBuilder(
                stream: firebaseService.getRoomsByHospitalId(
                  hospital?.id ?? "",
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final rooms = snapshot.data!;

                  if (rooms.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("Tidak ada chat"),
                    );
                  }

                  // Fetch semua data user sekali saja
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    fetchUsersOnce(rooms, chat);
                  });

                  return Column(
                    children: rooms.map((room) {
                      final roomId = room["id"];
                      final userAId = room["userAId"];
                      final user = userCache[userAId];

                      if (user == null) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: const Row(
                            children: [
                              CircleAvatar(radius: 20),
                              SizedBox(width: 12),
                              Expanded(child: LinearProgressIndicator()),
                            ],
                          ),
                        );
                      }

                      return ChatItem(
                        avatarUrl:
                            user.image ??
                            "https://i.pinimg.com/736x/1d/ec/e2/1dece2c8357bdd7cee3b15036344faf5.jpg",
                        name: user.name,
                        message: room['latestMessage'],
                        time: "",
                        roomId: roomId,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChatList extends StatelessWidget implements PreferredSizeWidget {
  const BarChatList({super.key});

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
