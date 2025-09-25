import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatList();
}

class _ChatList extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Data error")));
  }
}
