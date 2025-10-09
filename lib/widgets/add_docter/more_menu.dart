import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoreMenu extends StatefulWidget {
  final String docterId;
  const MoreMenu({super.key, required this.docterId});

  @override
  State<MoreMenu> createState() => _MoreMenu();
}

class _MoreMenu extends State<MoreMenu> {
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
      ],
    );

    if (selected == 'edit') {
      // Aksi edit
      context.push("/edit-docter/${widget.docterId}");
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
