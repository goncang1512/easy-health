import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/get_session.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfileScreen> {
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
