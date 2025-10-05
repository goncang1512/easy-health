import 'package:easyhealth/provider/auth_provider.dart';
import 'package:easyhealth/provider/navigation_provider.dart';
import 'package:easyhealth/screens/add_docter_screen.dart';
import 'package:easyhealth/screens/booking_screen.dart';
import 'package:easyhealth/screens/chatlist_screen.dart';
import 'package:easyhealth/screens/dashboard_screen.dart';
import 'package:easyhealth/screens/docter_screen.dart';
import 'package:easyhealth/screens/edit_hospital_screen.dart';
import 'package:easyhealth/screens/home_screen.dart';
import 'package:easyhealth/screens/hospital_screen.dart';
import 'package:easyhealth/screens/login_screen.dart';
import 'package:easyhealth/screens/notif_screen.dart';
import 'package:easyhealth/screens/profile_screen.dart';
import 'package:easyhealth/screens/register_hospital.dart';
import 'package:easyhealth/screens/register_screen.dart';
import 'package:easyhealth/screens/search_screen.dart';
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

List<StatefulShellBranch> buildBranches(String role) {
  return [
    // Home, Booking, Searching, dll (tetap)
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Home",
          path: "/home",
          builder: (context, state) {
            if (role == "Admin") {
              return DashboardScreen();
            } else {
              return HomeScreen();
            }
          },
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Booking",
          path: '/booking',
          builder: (context, state) => const BookingScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: role == "Admin" ? "Pesan" : "Searching",
          path: role == "Admin" ? "/message" : '/search',
          builder: (context, state) {
            if (role == "Admin") {
              return ChatListScreen();
            } else {
              final keyword = state.uri.queryParameters['keyword'];

              return SearchScreen(keyword: keyword);
            }
          },
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Notification",
          path: '/notification',
          builder: (c, s) {
            return const NotifScreen();
          },
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Profile",
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ];
}

GoRouter createRouter(String role) {
  return GoRouter(
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

          return HospitalScreen(hospitalId: hospitalId);
        },
      ),

      GoRoute(
        path: "/docter/:docter_id",
        name: "Docter",
        builder: (context, state) {
          final String docterId = state.pathParameters["docter_id"]!;

          return DocterScreen(docterId: docterId);
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

          return AddDocterScreen(hospitalId: hospitalId);
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
    ],
  );
}
