import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatItem extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String message;
  final String time;
  final String roomId;

  const ChatItem({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.message,
    required this.time,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ✅ Navigasi ke GoRoute kamu
        context.push('/chat-room/$roomId');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(avatarUrl), radius: 25),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(time, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
