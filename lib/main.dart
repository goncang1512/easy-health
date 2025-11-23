import 'package:easyhealth/provider/message_provider.dart';
import 'package:easyhealth/provider/navigation_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/config/global_key.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';

// IMPORT CHAT PROVIDER BARU
import 'package:easyhealth/provider/chat_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sessionManager = SessionManager();
  await sessionManager.loadSession();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SessionManager>.value(value: sessionManager),
        ChangeNotifierProvider<MessageProvider>(
          create: (_) => MessageProvider(session: sessionManager.session),
        ),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),

        // 👉 DAFTARKAN CHAT PROVIDER
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EasyHealth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: createRouter("Pacient"),
    );
  }
}
