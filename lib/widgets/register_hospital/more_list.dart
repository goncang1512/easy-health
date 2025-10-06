import 'package:easyhealth/provider/hospital_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreList extends StatefulWidget {
  const MoreList({super.key});

  @override
  State<MoreList> createState() => _MoreList();
}

class _MoreList extends State<MoreList> {
  Future shoListMenu() async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset buttonTopRight = button.localToGlobal(
      button.size.topRight(Offset.zero),
      ancestor: overlay,
    );

    final RelativeRect position = RelativeRect.fromLTRB(
      buttonTopRight.dx, // kiri
      buttonTopRight.dy, // atas
      overlay.size.width - buttonTopRight.dx, // kanan
      overlay.size.height - buttonTopRight.dy, // bawah
    );

    final selected = await showMenu<String>(
      context: context,
      position: position,
      items: [
        const PopupMenuItem<String>(
          value: 'edit',
          child: Text('Edit Rumah Sakit'),
        ),
        const PopupMenuItem<String>(value: 'delete', child: Text('Enroll')),
      ],
    );

    if (selected == 'edit') {
      // Aksi edit
    } else if (selected == 'delete') {
      // Aksi hapus
      final provider = context.read<SessionManager>();
      final regis = context.read<HospitalProvider>();
      await regis.enrollHospital();

      await provider.loadSession();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12), // padding kiri & kanan
      child: SizedBox(
        width: 40,
        height: 40,
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(Icons.more_vert),
          onPressed: () => shoListMenu(),
        ),
      ),
    );
  }
}
