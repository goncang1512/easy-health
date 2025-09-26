import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarSearch({super.key, this.title = "Pencarian"});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: context.canPop()
          ? IconButton(
              onPressed: () => context.pop(),
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
