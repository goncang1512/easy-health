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
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await context.read<SessionManager>().clearSession();
                // ignore: use_build_context_synchronously
                context.go("/login");
              },
              child: Text("LOG OUT dari $name"),
            ),
          ],
        ),
      ),
    );
  }
}
