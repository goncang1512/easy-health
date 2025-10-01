import 'package:easyhealth/provider/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SessionManager()..loadSession(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionManager>(
      builder: (context, sessionManager, _) {
        final router = createRouter(
          sessionManager.session?.user.role ?? "Pacient",
        );

        return MaterialApp.router(
          title: 'EasyHealth',
          debugShowCheckedModeBanner: false,
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
