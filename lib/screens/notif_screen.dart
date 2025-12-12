import 'package:easyhealth/models/notif_model.dart';
import 'package:easyhealth/provider/notif_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({super.key});

  @override
  State<NotifScreen> createState() => _NotifPage();
}

class _NotifPage extends State<NotifScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotifProvider>();
    final userId = context.watch<SessionManager>().session?.user.id;

    return Scaffold(
      body: SafeArea(
        child: userId == null
            ? const Center(child: Text("User tidak ditemukan"))
            : StreamBuilder<List<NotifModel>>(
                stream: provider.getNotif(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Tidak ada notifikasi"));
                  }

                  final notifList = snapshot.data!;

                  return ListView.builder(
                    itemCount: notifList.length,
                    itemBuilder: (context, index) {
                      final notif = notifList[index];
                      return buildNotifItem(notif);
                    },
                  );
                },
              ),
      ),
    );
  }

  IconData getNotifIcon(String title) {
    final t = title.toLowerCase();

    if (t.contains("batal")) return Icons.cancel; // CANCEL
    if (t.contains("konfirmasi")) return Icons.check_circle; // CONFIRM
    if (t.contains("selesai")) return Icons.done_all; // FINISH

    return Icons.notifications; // default
  }

  Color getNotifColor(String title) {
    final t = title.toLowerCase();

    if (t.contains("batal")) return Colors.red; // CANCEL
    if (t.contains("konfirmasi")) return Colors.blue; // CONFIRM
    if (t.contains("selesai")) return Colors.green; // FINISH

    return Colors.grey; // default
  }

  Widget buildNotifItem(NotifModel notif) {
    final icon = getNotifIcon(notif.title);
    final color = getNotifColor(notif.title);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          notif.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(notif.message, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
