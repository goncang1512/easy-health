import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/get_session.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePage();
}

class _HomePage extends State<HomeScreen> {
  String? name;

  @override
  void initState() {
    super.initState();
    _loadRefreshToken();
  }

  void _loadRefreshToken() async {
    final data = await UseSession.getSession();

    setState(() {
      name = data?.user.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SessionManager>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await context.read<SessionManager>().clearSession();
                  // ignore: use_build_context_synchronously
                  context.go("/login");
                },
                child: Column(
                  children: [
                    Text("LOG OUT dari ${data.session?.user.name}"),
                    Text("ROLE ${data.session?.user.role}"),
                  ],
                ),
              ),
              data.session?.docter?.id == null
                  ? ElevatedButton(
                      onPressed: () {
                        // ignore: use_build_context_synchronously
                        context.push("/add-docter");
                      },
                      child: Column(children: [Text("Daftar sebagai dokter")]),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        // ignore: use_build_context_synchronously
                        context.push(
                          "/edit-docter/${data.session?.docter?.id}",
                        );
                      },
                      child: Column(children: [Text("Edit Dokter")]),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
