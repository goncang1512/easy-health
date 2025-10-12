import 'package:easyhealth/provider/navigation_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/config/global_key.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sessionManager = SessionManager();
  await sessionManager.loadSession();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SessionManager>.value(value: sessionManager),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
