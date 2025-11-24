import 'package:easyhealth/provider/message_provider.dart';
import 'package:easyhealth/provider/navigation_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/config/global_key.dart';
import 'package:easyhealth/utils/get_session.dart';
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
  String? _lastStatus;

  Future<void> _updateUserStatus(String userId, String newStatus) async {
    // Hindari request berulang
    if (_lastStatus == newStatus) return;
    _lastStatus = newStatus;

    try {
      await statusUser(userId, newStatus);
    } catch (e) {
      debugPrint("Failed to update user status: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final data = context.read<SessionManager>();
    final userId = data.session?.user.id;

    if (userId != null) {
      _updateUserStatus(userId, "online");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final data = context.read<SessionManager>();
    final userId = data.session?.user.id;
    if (userId == null) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _updateUserStatus(userId, "online");
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        _updateUserStatus(userId, "offline");
        break;
      case AppLifecycleState.hidden:
        throw UnimplementedError();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    final data = context.read<SessionManager>();
    final userId = data.session?.user.id;
    if (userId != null) {
      _updateUserStatus(userId, "offline");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<SessionManager, String>(
      selector: (_, session) => session.session?.user.role ?? "Pacient",
      builder: (context, role, _) {
        final router = createRouter(role);

        router.routerDelegate.addListener(() {
          rootScaffoldMessengerKey.currentState?.hideCurrentMaterialBanner();
        });

        return MaterialApp.router(
          title: 'EasyHealth',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router,
        );
      },
    );
  }
}
