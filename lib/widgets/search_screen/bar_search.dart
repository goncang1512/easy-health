import 'package:flutter/material.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarSearch({super.key, this.title = "Pencarian"});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt, color: Colors.green),
          onPressed: () {
            // aksi filter
          },
        ),
      ],
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black, // biar icon/teks jadi hitam
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
