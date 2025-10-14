import 'package:easyhealth/config/branch_app.dart';
import 'package:easyhealth/provider/auth_provider.dart';
import 'package:easyhealth/provider/booking_provider.dart';
import 'package:easyhealth/provider/docter_provider.dart';
import 'package:easyhealth/provider/message_provider.dart';
import 'package:easyhealth/provider/navigation_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/screens/add_docter_screen.dart';
import 'package:easyhealth/screens/chat_screen.dart';
import 'package:easyhealth/screens/docter_screen.dart';
import 'package:easyhealth/screens/edit_docter_screen.dart';
import 'package:easyhealth/screens/edit_hospital_screen.dart';
import 'package:easyhealth/screens/hospital_screen.dart';
import 'package:easyhealth/screens/login_screen.dart';
import 'package:easyhealth/screens/register_hospital.dart';
import 'package:easyhealth/screens/register_screen.dart';
import 'package:easyhealth/screens/splash_screen.dart';
import 'package:easyhealth/widgets/bottom_navigation_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static const String signIn = '/login';
  static const String signUp = '/register';
  static const String home = '/home';
  static const String favorites = '/booking';
  static const String profile = '/profile';
  static const String details = '/notifications';
}

GoRouter createRouter(String role) {
  final GoRouter router = GoRouter(
    initialLocation: "/splash",
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          final navProvider = context.read<NavigationProvider>();
          navProvider.setShell(navigationShell);

          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: BottomNavigationShell(
              navigationShell: navigationShell,
              role: role,
            ),
          );
        },
        branches: buildBranches(role),
      ),

      GoRoute(
        path: "/login",
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ChangeNotifierProvider(
            create: (_) => AuthProvider(),
            child: const LoginScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fromSplash = state.extra == "fromSplash";
            if (fromSplash) {
              return FadeTransition(opacity: animation, child: child);
            }
            return child;
          },
        ),
      ),

      GoRoute(
        path: "/register",
        name: "Registrasi",
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => AuthProvider(),
            child: RegisterScreen(),
          );
        },
      ),

      GoRoute(
        path: "/splash",
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Splash muncul tanpa animasi
            return child;
          },
        ),
      ),

      GoRoute(
        path: "/hospital/:hospital_id",
        name: "Hospital",
        builder: (context, state) {
          final String hospitalId = state.pathParameters["hospital_id"]!;
          final session = context.read<SessionManager>();

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => MessageProvider(session: session.session),
              ),
            ],
            child: HospitalScreen(hospitalId: hospitalId),
          );
        },
      ),

      GoRoute(
        path: "/docter/:docter_id",
        name: "Docter",
        builder: (context, state) {
          final String docterId = state.pathParameters["docter_id"]!;

          return ChangeNotifierProvider(
            create: (_) => BookingProvider(docterId: docterId),
            child: DocterScreen(docterId: docterId),
          );
        },
      ),

      GoRoute(
        path: "/register/hospital",
        name: "Register Hospital",
        builder: (context, state) => RegisterHospital(),
      ),

      GoRoute(
        path: "/add-docter/:hospital_id",
        name: "Add Docter",
        builder: (context, state) {
          final String hospitalId = state.pathParameters["hospital_id"]!;
          final session = context.read<SessionManager>();

          return ChangeNotifierProvider(
            create: (_) => DocterProvider(
              session: session.session,
              hospitalId: hospitalId,
            ),
            child: AddDocterScreen(hospitalId: hospitalId),
          );
        },
      ),

      GoRoute(
        path: "/register/hospital/:hospital_id",
        name: "Edit Hospital",
        builder: (context, state) {
          final String hospitalId = state.pathParameters["hospital_id"]!;

          return EditHospitalScreen(hospitalId: hospitalId);
        },
      ),

      GoRoute(
        path: "/edit-docter/:docter_id",
        name: "Edit docter",
        builder: (context, state) {
          final String docterId = state.pathParameters["docter_id"]!;
          final session = context.read<SessionManager>();

          return ChangeNotifierProvider(
            create: (_) =>
                DocterProvider(session: session.session, docterId: docterId),
            child: EditDocterScreen(docterId: docterId),
          );
        },
      ),

      GoRoute(
        path: "/chat-room/:room_id",
        name: "Chat Room",
        builder: (context, state) {
          final String roomId = state.pathParameters["room_id"]!;
          final session = context.read<SessionManager>();

          return ChangeNotifierProvider(
            create: (_) => MessageProvider(session: session.session),
            child: ChatScreen(roomId: roomId),
          );
        },
      ),
    ],
  );

  return router;
}
