import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "./routes.dart";

Future<void> main() async {
  // Pastikan binding Flutter ready
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = createRouter("Pacient");

    return MaterialApp.router(
      title: 'EasyHealth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
