import 'package:easyhealth/utils/get_session.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  UseSession.logOut(context);
                },
                child: Text("LOG OUT dari $name"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
