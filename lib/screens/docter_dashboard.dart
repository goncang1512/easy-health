import 'package:easyhealth/provider/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DocterDashboard extends StatelessWidget {
  const DocterDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SessionManager>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard ${data.session?.user.name ?? "Docter"}"),
        centerTitle: false,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12), // padding kiri & kanan
            child: SizedBox(
              width: 40,
              height: 40,
              child: data.session?.hospital != null
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context.push(
                          "/edit-docter/${data.session?.docter?.id}",
                        );
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
      body: Center(child: Text("Docter Dashboard")),
    );
  }
}
