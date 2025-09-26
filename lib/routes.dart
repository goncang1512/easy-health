import 'package:easyhealth/screens/booking_screen.dart';
import 'package:easyhealth/screens/docter_screen.dart';
import 'package:easyhealth/screens/home_screen.dart';
import 'package:easyhealth/screens/hospital_screen.dart';
import 'package:easyhealth/screens/login_screen.dart';
import 'package:easyhealth/screens/notif_screen.dart';
import 'package:easyhealth/screens/profile_screen.dart';
import 'package:easyhealth/screens/search_screen.dart';
import 'package:easyhealth/screens/splash_screen.dart';
import 'package:easyhealth/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/splash",
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: ButtonNavBar(
            role: "pacient",
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: "Home",
              path: "/",
              builder: (context, state) => HomeScreen(),
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
              name: "Searching",
              path: '/search',
              builder: (context, state) {
                final keyword = state.uri.queryParameters['keyword'];

                return SearchScreen(keyword: keyword);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: "Notification",
              path: '/notification',
              builder: (context, state) => const NotifScreen(),
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
      ],
    ),

    GoRoute(
      path: "/login",
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginScreen(),
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
  ],
);
